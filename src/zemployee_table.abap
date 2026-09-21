@EndUserText.label : 'Employee Master Data'
@AbapCatalog.tableCategory : #TRANSPARENT
@AbapCatalog.deliveryClass : #A
@AbapCatalog.dataMaintenance : #RESTRICTED
define table zemployee {
  key employee_id type i;
  first_name    type char30;
  last_name     type char30;
  email         type char60;
  department    type char30;
  position      type char30;
  hire_date     type datum;
  salary        type p length 8 decimals 2;
  status        type char20;
  created_by    type syuname;
  created_at    type timestampl;
  changed_by    type syuname;
  changed_at    type timestampl;
}
