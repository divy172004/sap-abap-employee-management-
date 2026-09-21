REPORT z_employee_management.

DATA: go_employee TYPE REF TO zcl_employee_mgmt.
DATA: ls_employee TYPE zcl_employee_mgmt=>ty_employee.
DATA: lt_employees TYPE STANDARD TABLE OF zcl_employee_mgmt=>ty_employee WITH EMPTY KEY.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
PARAMETERS: p_mode TYPE c LENGTH 1 RADIOBUTTON GROUP grp1 USER-COMMAND ucomm DEFAULT 'X',
            p_create RADIOBUTTON GROUP grp1,
            p_read   RADIOBUTTON GROUP grp1,
            p_update RADIOBUTTON GROUP grp1,
            p_delete RADIOBUTTON GROUP grp1,
            p_list   RADIOBUTTON GROUP grp1.
SELECTION-SCREEN END OF BLOCK b1.

SELECTION-SCREEN BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002.
PARAMETERS: p_empid   TYPE i,
            p_fname   TYPE char30,
            p_lname   TYPE char30,
            p_email   TYPE char60,
            p_dept    TYPE char30,
            p_pos     TYPE char30,
            p_hdate   TYPE datum,
            p_salary  TYPE p LENGTH 8 DECIMALS 2,
            p_status  TYPE char20.
SELECTION-SCREEN END OF BLOCK b2.

INITIALIZATION.
  TEXT-001 = 'Operation'.
  TEXT-002 = 'Employee Details'.

START-OF-SELECTION.
  go_employee = NEW zcl_employee_mgmt( ).

  IF p_create = abap_true.
    ls_employee = VALUE #( employee_id = p_empid
                           first_name = p_fname
                           last_name  = p_lname
                           email      = p_email
                           department = p_dept
                           position   = p_pos
                           hire_date  = p_hdate
                           salary     = p_salary
                           status     = p_status ).

    IF go_employee->create_employee( ls_employee ) = abap_true.
      WRITE: / 'Employee created successfully.'.
    ELSE.
      WRITE: / 'Employee already exists or creation failed.'.
    ENDIF.

  ELSEIF p_read = abap_true.
    ls_employee = go_employee->read_employee( p_empid ).

    IF ls_employee-employee_id IS INITIAL.
      WRITE: / 'No employee found for the given ID.'.
    ELSE.
      WRITE: / 'Employee ID: ', ls_employee-employee_id.
      WRITE: / 'Name: ', ls_employee-first_name, ' ', ls_employee-last_name.
      WRITE: / 'Email: ', ls_employee-email.
      WRITE: / 'Department: ', ls_employee-department.
      WRITE: / 'Position: ', ls_employee-position.
      WRITE: / 'Hire Date: ', ls_employee-hire_date.
      WRITE: / 'Salary: ', ls_employee-salary.
      WRITE: / 'Status: ', ls_employee-status.
    ENDIF.

  ELSEIF p_update = abap_true.
    ls_employee = VALUE #( employee_id = p_empid
                           first_name = p_fname
                           last_name  = p_lname
                           email      = p_email
                           department = p_dept
                           position   = p_pos
                           hire_date  = p_hdate
                           salary     = p_salary
                           status     = p_status ).

    IF go_employee->update_employee( ls_employee ) = abap_true.
      WRITE: / 'Employee updated successfully.'.
    ELSE.
      WRITE: / 'Employee not found or update failed.'.
    ENDIF.

  ELSEIF p_delete = abap_true.
    IF go_employee->delete_employee( p_empid ) = abap_true.
      WRITE: / 'Employee deleted successfully.'.
    ELSE.
      WRITE: / 'Employee not found or delete failed.'.
    ENDIF.

  ELSEIF p_list = abap_true.
    lt_employees = go_employee->list_employees( ).

    IF lines( lt_employees ) = 0.
      WRITE: / 'No employees found.'.
    ELSE.
      WRITE: / 'Employee List'.
      LOOP AT lt_employees INTO ls_employee.
        WRITE: / |{ ls_employee-employee_id } |,
                  |{ ls_employee-first_name } { ls_employee-last_name } |,
                  |{ ls_employee-department } |,
                  |{ ls_employee-position } |,
                  |{ ls_employee-status }|.
      ENDLOOP.
    ENDIF.
  ENDIF.
