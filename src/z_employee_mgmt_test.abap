CLASS lcl_employee_mgmt_test DEFINITION FINAL FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA mo_employee TYPE REF TO zcl_employee_mgmt.

    METHODS:
      setup,
      create_and_read FOR TESTING.

ENDCLASS.

CLASS lcl_employee_mgmt_test IMPLEMENTATION.

  METHOD setup.
    mo_employee = NEW zcl_employee_mgmt( ).
  ENDMETHOD.

  METHOD create_and_read.
    DATA ls_employee TYPE zcl_employee_mgmt=>ty_employee.

    ls_employee = VALUE #( employee_id = 1001
                           first_name = 'Alice'
                           last_name  = 'Johnson'
                           email      = 'alice.johnson@example.com'
                           department = 'IT'
                           position   = 'Developer'
                           hire_date  = '20240115'
                           salary     = '75000.00'
                           status     = 'Active' ).

    cl_abap_unit_assert=>assert_equals(
      act = mo_employee->create_employee( ls_employee )
      exp = abap_true ).

    ls_employee = mo_employee->read_employee( 1001 ).

    cl_abap_unit_assert=>assert_equals(
      act = ls_employee-first_name
      exp = 'Alice' ).

    mo_employee->delete_employee( 1001 ).
  ENDMETHOD.

ENDCLASS.
