use employee
select * from users

select * from logins


--1. Management wants to see all the users that did not login in the past 3 months
--returnn : username
--today(13-aprl-2025)


--Soltion 1

--Step 1 (this will get the date 3 months from today(13-aprl-2025))
select * , dateadd(month,-3,GETDATE()) 
from logins
order by USER_ID,LOGIN_TIMESTAMP;

select USER_ID,Max(login_timestamp) -- dateadd(month,-3,GETDATE()) from logins
from logins
group by USER_ID
having Max(login_timestamp) < dateadd(month,-3,GETDATE());

--Solution 2
with CTE as (
select User_id
from logins
where login_timestamp > dateadd(month,-3,getdate())
)

select Distinct(User_Id) 
from logins 
where user_id not in (select * from CTE);


-------------------------------------------------------------------------------------------------------

--2. For the business units quartely analysis, calculate how many users and how many sessions were at each quater
-- order by Qyater from newest to oldest
-- Return : First day of the quater, user_cnt, session_cnt.

--Step 1
select *,datepart(quarter, LOGIN_TIMESTAMP) from logins
-- It will give the quarter number

--Step 2
select --datepart(quarter, LOGIN_TIMESTAMP) as quarter_num, 
count(*) as session_cnt, 
count(Distinct User_id) as user_count,
--Min(Login_timestamp) as quarter_first_login,
DATETRUNC(quarter,Min(Login_timestamp)) as first_quarter_date
from logins
group by datepart(quarter, LOGIN_TIMESTAMP)



-------------------------------------------------------------------------------------------------------

--3.Display user id's that login in jan 2024 and did not login on nov-2023
--Return : User_id

--Step 1 (To view Jan 2025 month only)
select * 
from logins
where LOGIN_TIMESTAMP between '2025-01-01' and '2025-01-31'
-- 1,2,3,5

--Step 2 (To view Nov 2024  only)
select * 
from logins
where LOGIN_TIMESTAMP between '2024-11-01' and '2024-11-30' 
--2,4,6,7
--Error may occure bcz in november there is no 31 dats 
--(where LOGIN_TIMESTAMP between '2024-11-01' and '2024-11-31' )

--Final Code
select distinct user_id
from logins
where LOGIN_TIMESTAMP between '2025-01-01' and '2025-01-31'
and user_id not in (select user_id
from logins
where LOGIN_TIMESTAMP between '2024-11-01' and '2024-11-30' 
 )

--Answer : 1,3,5

-------------------------------------------------------------------------------------------------------

--4. Add to the query from 2 the percentage change in sssions from last quarter.
-- Return : First day of the quarter, session_cnt,session_cnt_prev,Session_percent_change.
  
with cte as (select DATETRUNC(quarter,Min(Login_timestamp)) as first_quarter_date,
--datepart(quarter, LOGIN_TIMESTAMP) as quarter_num, 
count(*) as session_cnt, 
count(Distinct User_id) as user_count
--Min(Login_timestamp) as quarter_first_login,
from logins
group by datepart(quarter, LOGIN_TIMESTAMP))
--order by first_quarter_date

select *,
Lag(session_cnt,1) over(order by first_quarter_date) as prev_session_cnt,
cast((session_cnt - (Lag(session_cnt,1) over(order by first_quarter_date)))*100.0/(Lag(session_cnt,1) over(order by first_quarter_date)) as int) as Session_percent_change
from cte

--The CAST() function converts a value (of any type) into a specified datatype. [Float -- > int]

-------------------------------------------------------------------------------------------------------

--5. Display the user that has the highest session score (Max) for each day
--Return : Date,username,score
select * from logins
 
with cte as(
select user_id,cast(login_timestamp as date) as login_date 
,sum(session_score) as score
from logins
group by USER_ID,CAST(login_timestamp as date))
--order by CAST(login_timestamp as date),score)

select * from (
select *,
row_number() over(partition by login_date order by score desc) as rn
from cte ) as a 
where rn =1


-------------------------------------------------------------------------------------------------------

--6. To identify our best users - Return the users that had a session on every single day since their first login
-- makeassumptions if needed.
-- Return  User_ID
--13-04-2025

select * from logins order by user_id,LOGIN_TIMESTAMP

select user_id,min(cast(login_timestamp as date)) as first_login,
datediff(day,Min(cast(login_timestamp as date)),GETDATE())+1 as no_of_login_days_required,
count(distinct cast(login_timestamp as date)) as no_of_login_days
from logins 
group by user_id
having datediff(day,Min(cast(login_timestamp as date)),GETDATE())+1 =count(distinct cast(login_timestamp as date))
order by USER_ID

-- Answer vary (It depends upons the current date)

-------------------------------------------------------------------------------------------------------


--7. on what dates there were no log-in at all?
--Return : Login_dates
--2024-07-15 to 2025-04-15

select cast(Min(Login_timestamp)as date) as first_date,
cast(getdate() as date) as last_date
from logins

--Solution 1
with cte as(
select cast(Min(Login_timestamp)as date) as first_date,
cast(getdate() as date) as last_date
from logins
union all
select dateadd(day,1,first_date) as first_date, last_date from cte
where first_date < last_date
)
select * from cte
where first_date not in (select distinct cast(Login_timestamp as date) from logins)
option(maxrecursion 500)

--Solution 2
select cal_date
from cal_dim_new c
inner join(select cast(Min(Login_timestamp)as date) as first_date,
cast(getdate() as date) as last_date
from logins) as a on c.cal_date between first_date and last_date
where cal_date not in
(select distinct cast(Login_timestamp as date) from logins)



