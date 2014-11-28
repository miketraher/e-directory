
/* add order_to_show to division_lookup */

alter table division_lookup add order_to_show int null;
GO

update division_lookup
set order_to_show = 0
GO

alter table division_lookup add constraint DF_division_lookup_order_to_show default 0 FOR order_to_show;
GO

alter table division_lookup alter column order_to_show int not null;
GO






alter table employee add expertise nvarchar(1000) null;
GO
CREATE TABLE [dbo].[employee_company](
     [emp_company_id] [int] IDENTITY(1,1) NOT NULL,
     [emp_id] int NULL,
     [company_id] int NULL,
CONSTRAINT [PK_employee_company] PRIMARY KEY CLUSTERED
(
     [emp_company_id] ASC
))
GO

/* to populate */
insert into employee_company
select emp_id, company_id
from employee;
GO

alter table employee_company alter column emp_id int not null;
GO


