CLASS zcl_employee_mgmt DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_employee,
             employee_id TYPE i,
             first_name TYPE char30,
             last_name  TYPE char30,
             email      TYPE char60,
             department TYPE char30,
             position   TYPE char30,
             hire_date  TYPE datum,
             salary     TYPE p LENGTH 8 DECIMALS 2,
             status     TYPE char20,
           END OF ty_employee.

    METHODS:
      create_employee IMPORTING is_employee TYPE ty_employee
                     RETURNING VALUE(rv_success) TYPE abap_bool,
      read_employee  IMPORTING iv_employee_id TYPE i
                     RETURNING VALUE(rs_employee) TYPE ty_employee,
      update_employee IMPORTING is_employee TYPE ty_employee
                     RETURNING VALUE(rv_success) TYPE abap_bool,
      delete_employee IMPORTING iv_employee_id TYPE i
                     RETURNING VALUE(rv_success) TYPE abap_bool,
      list_employees RETURNING VALUE(rt_employees) TYPE STANDARD TABLE OF ty_employee WITH EMPTY KEY.

ENDCLASS.

CLASS zcl_employee_mgmt IMPLEMENTATION.

  METHOD create_employee.
    DATA ls_employee TYPE zemployee.

    SELECT SINGLE *
      FROM zemployee
      INTO @ls_employee
      WHERE employee_id = @is_employee-employee_id.

    IF sy-subrc = 0.
      rv_success = abap_false.
      RETURN.
    ENDIF.

    ls_employee = VALUE #( employee_id = is_employee-employee_id
                           first_name = is_employee-first_name
                           last_name  = is_employee-last_name
                           email      = is_employee-email
                           department = is_employee-department
                           position   = is_employee-position
                           hire_date  = is_employee-hire_date
                           salary     = is_employee-salary
                           status     = is_employee-status
                           created_by = sy-uname
                           created_at = utclong_current( )
                           changed_by = sy-uname
                           changed_at = utclong_current( ) ).

    INSERT zemployee FROM ls_employee.
    IF sy-subrc = 0.
      rv_success = abap_true.
    ELSE.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD read_employee.
    DATA ls_employee TYPE zemployee.

    CLEAR rs_employee.

    SELECT SINGLE *
      FROM zemployee
      INTO @ls_employee
      WHERE employee_id = @iv_employee_id.

    IF sy-subrc = 0.
      rs_employee = VALUE #( employee_id = ls_employee-employee_id
                             first_name = ls_employee-first_name
                             last_name  = ls_employee-last_name
                             email      = ls_employee-email
                             department = ls_employee-department
                             position   = ls_employee-position
                             hire_date  = ls_employee-hire_date
                             salary     = ls_employee-salary
                             status     = ls_employee-status ) .
    ENDIF.
  ENDMETHOD.

  METHOD update_employee.
    DATA ls_employee TYPE zemployee.

    SELECT SINGLE *
      FROM zemployee
      INTO @ls_employee
      WHERE employee_id = @is_employee-employee_id.

    IF sy-subrc <> 0.
      rv_success = abap_false.
      RETURN.
    ENDIF.

    ls_employee = VALUE #( employee_id = is_employee-employee_id
                           first_name = is_employee-first_name
                           last_name  = is_employee-last_name
                           email      = is_employee-email
                           department = is_employee-department
                           position   = is_employee-position
                           hire_date  = is_employee-hire_date
                           salary     = is_employee-salary
                           status     = is_employee-status
                           created_by = ls_employee-created_by
                           created_at = ls_employee-created_at
                           changed_by = sy-uname
                           changed_at = utclong_current( ) ).

    UPDATE zemployee FROM ls_employee.
    IF sy-subrc = 0.
      rv_success = abap_true.
    ELSE.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD delete_employee.
    DELETE FROM zemployee WHERE employee_id = @iv_employee_id.

    IF sy-subrc = 0.
      rv_success = abap_true.
    ELSE.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.

  METHOD list_employees.
    CLEAR rt_employees.

    SELECT employee_id, first_name, last_name, email, department, position, hire_date, salary, status
      FROM zemployee
      INTO TABLE @rt_employees.
  ENDMETHOD.

ENDCLASS.
