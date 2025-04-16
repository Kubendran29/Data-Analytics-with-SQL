
use employee --Database

--Script to create a users and logins Table.

drop table logins
drop table  users

CREATE TABLE users (
    USER_ID INT PRIMARY KEY,
    USER_NAME VARCHAR(20) NOT NULL,
    USER_STATUS VARCHAR(20) NOT NULL
);

CREATE TABLE logins (
    USER_ID INT,
    LOGIN_TIMESTAMP DATETIME NOT NULL,
    SESSION_ID INT PRIMARY KEY,
    SESSION_SCORE INT,
    FOREIGN KEY (USER_ID) REFERENCES USERS(USER_ID)
);

-- Users Table
INSERT INTO USERS VALUES (1, 'Alice', 'Active');
INSERT INTO USERS VALUES (2, 'Bob', 'Inactive');
INSERT INTO USERS VALUES (3, 'Charlie', 'Active');
INSERT INTO USERS  VALUES (4, 'David', 'Active');
INSERT INTO USERS  VALUES (5, 'Eve', 'Inactive');
INSERT INTO USERS  VALUES (6, 'Frank', 'Active');
INSERT INTO USERS  VALUES (7, 'Grace', 'Inactive');
INSERT INTO USERS  VALUES (8, 'Heidi', 'Active');
INSERT INTO USERS VALUES (9, 'Ivan', 'Inactive');
INSERT INTO USERS VALUES (10, 'Judy', 'Active');

-- Logins Table 

INSERT INTO LOGINS  VALUES (1, '2024-07-15 09:30:00', 1001, 85);
INSERT INTO LOGINS VALUES (2, '2024-07-22 10:00:00', 1002, 90);
INSERT INTO LOGINS VALUES (3, '2024-08-10 11:15:00', 1003, 75);
INSERT INTO LOGINS VALUES (4, '2024-08-20 14:00:00', 1004, 88);
INSERT INTO LOGINS  VALUES (5, '2024-09-05 16:45:00', 1005, 82);
INSERT INTO LOGINS  VALUES (6, '2024-10-12 08:30:00', 1006, 77);
INSERT INTO LOGINS  VALUES (7, '2024-11-18 09:00:00', 1007, 81);
INSERT INTO LOGINS VALUES (8, '2024-12-01 10:30:00', 1008, 84);
INSERT INTO LOGINS  VALUES (9, '2024-12-15 13:15:00', 1009, 79);


-- 2025 Q1
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2025-01-10 07:45:00', 1011, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2025-01-25 09:30:00', 1012, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2025-01-05 11:00:00', 1013, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2025-02-01 14:30:00', 1014, 91);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2025-02-15 16:00:00', 1015, 83);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2025-03-12 08:00:00', 1016, 80);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (7, '2025-04-8 09:15:00', 1017, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (8, '2025-04-8 10:45:00', 1018, 87);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (9, '2025-04-15 13:30:00', 1019, 76);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2025-04-10 15:00:00', 1010, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2025-04-11 15:45:00', 1020, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2025-04-12 15:00:00', 1021, 92);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (10, '2025-04-13 15:45:00', 1022, 93);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (1, '2025-01-10 07:45:00', 1101, 86);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (3, '2025-01-25 09:30:00', 1102, 89);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (5, '2025-01-15 11:00:00', 1103, 78);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (2, '2024-11-10 07:45:00', 1201, 82);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (4, '2024-11-25 09:30:00', 1202, 84);
INSERT INTO LOGINS (USER_ID, LOGIN_TIMESTAMP, SESSION_ID, SESSION_SCORE) VALUES (6, '2024-11-15 11:00:00', 1203, 80);




select * from users

select * from logins


--For calender Table
with cte as(
select cast('2000-01-01' as date) as cal_date
,datepart(year,'2000-01-01') as cal_year
,datepart(dayofyear, '2000-01-01') as cal_year_day
,datepart(quarter, '2000-01-01') as cal_quarter
,datepart(month, '2000-01-01') as cal_month
,datename(month, '2000-01-01') as cal_month_name
,datepart(day, '2000-01-01') as cal_month_day
,datepart(week, '2000-01-01') as cal_week
,datepart(weekday, '2000-01-01') as cal_week_day
,datename(weekday, '2000-01-01') as cal_day_name

union all

select dateadd(day,1,cal_date) as cal_date,
datepart(year,dateadd(day,1,cal_date)) as cal_year,
datepart(dayofyear,dateadd(day,1,cal_date)) as cal_year_day,
datepart(quarter,dateadd(day,1,cal_date)) as cal_quarter,
datepart(month,dateadd(day,1,cal_date)) as cal_month,
datename(month, dateadd(day,1,cal_date)) as cal_month_name,
datepart(day,dateadd(day,1,cal_date)) cal_month_day,
datepart(week,dateadd(day,1,cal_date)) cal_week,
datepart(weekday,dateadd(day,1,cal_date)) cal_week_day,
datename(weekday,dateadd(day,1,cal_date)) cal_day_name	
from cte
where cal_date <=cast('2025-12-30' as date)
)
select ROW_NUMBER() over(order by cal_date asc) as id , * into cal_dim_new
from cte
option(Maxrecursion 32676)

drop table cal_dim_new

select * from cal_dim_new 
order by id



