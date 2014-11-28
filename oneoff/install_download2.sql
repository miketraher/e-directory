USE [test-directory]
GO

DROP VIEW [dbo].[Full Employee Details]
GO



/****** Object:  View [dbo].[Full Employee Details]    Script Date: 10/11/2014 15:13:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[Full Employee Details]
AS
SELECT     e.emp_id, e.last_name, e.first_name, e.job_title, e.job_role, e.expertise, e.extension_number, e.phone_number, e.mobile_number, e.email_address, e.skype_id, 
                      c.ctry_name, e.ctry_id, d.division_name, e.division_id, e.company_id, dept.dept_name, e.dept_id, s.site_name, e.site_id, 
                      desk.desk_location_name, e.desk_location_id, report_to.first_name + ' ' + report_to.last_name AS report_to, e.report_to_emp_id, e.status, e.status_change_date
FROM         dbo.employee AS e LEFT OUTER JOIN
                      dbo.ctry_lookup AS c ON e.ctry_id = c.ctry_id LEFT OUTER JOIN
                      dbo.division_lookup AS d ON e.division_id = d.division_id LEFT OUTER JOIN
                      dbo.dept_lookup AS dept ON e.dept_id = dept.dept_id LEFT OUTER JOIN
                      dbo.site_lookup AS s ON e.site_id = s.site_id LEFT OUTER JOIN
                      dbo.desk_location_lookup AS desk ON e.desk_location_id = desk.desk_location_id LEFT OUTER JOIN
                      dbo.employee AS report_to ON e.report_to_emp_id = report_to.emp_id


GO


