IF OBJECT_ID('[dbo].[bridge_dates]', 'V') IS NOT NULL
DROP VIEW [dbo].[bridge_dates]
GO
create view bridge_dates as ( 
    select record_id ,dateadd( d  , x.row_id , emp_started_at ) as bride_date 
from department_employee 
inner join 
( SELECT value as row_id from generate_series(0, 1000 ) ) x 
on 
DATEDIFF( d ,emp_started_at, emp_ended_at ) >= x.row_id
)
GO 
IF OBJECT_ID('[dbo].[department_employee_extended]', 'V') IS NOT NULL
DROP VIEW [dbo].[department_employee_extended]
GO
create view department_employee_extended as  ( 
select u.* , 
bridge_dates.bride_date as dates  
from  department_employee u 
inner join 
bridge_dates 
on 
bridge_dates.record_id = u.record_id  
)
GO 