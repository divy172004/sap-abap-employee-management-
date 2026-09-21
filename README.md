# SAP ABAP Employee Management

This project contains a complete ABAP employee management example built with a database table, a business class, and a runnable report. It demonstrates the main CRUD operations: create, read, update, delete, and list employees.

## Objects included

- Database table: `ZEMPLOYEE`
- Business logic: `ZCL_EMPLOYEE_MGMT`
- Report: `Z_EMPLOYEE_MANAGEMENT`
- Unit test: `LCL_EMPLOYEE_MGMT_TEST`

## How to import into SAP

1. Open SAP GUI.
2. Create a package, for example `ZEMPLOYEE_MGMT`.
3. Import the following source objects into the package:
   - `ZEMPLOYEE` (table)
   - `ZCL_EMPLOYEE_MGMT` (class)
   - `Z_EMPLOYEE_MANAGEMENT` (report)
4. Activate all objects.
5. Run the report `Z_EMPLOYEE_MANAGEMENT` from SE38.

## Features

- Add employee records
- Search employee by ID
- Update employee details
- Delete employee records
- List all employees
- Unit test coverage for create and read flows

## Example usage

From the report menu:

- Select Create to add a new employee
- Select Read to fetch by employee ID
- Select Update to modify data
- Select Delete to remove a record
- Select List to display all employees

## Notes

This is a clean, minimal ABAP example designed for learning and demo purposes. It is intentionally simple and easy to extend with authorization checks, ALV display, or a custom transaction code.
