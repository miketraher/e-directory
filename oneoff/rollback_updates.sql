
/* add order_to_show to division_lookup */

alter table division_lookup drop constraint DF_division_lookup_order_to_show;
GO
alter table division_lookup drop column order_to_show;
GO
alter table employee drop column expertise;
GO
drop table employee_company;
GO