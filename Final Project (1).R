install.packages("RMySQL")
library(RMySQL)

##################################################################################################################################
#                                         Setting a MySQLWorkbench Connection Password
##################################################################################################################################

# Select a connection
# Go to "administration" on the top of the left side panel
# Under administration, select "users and privileges"
# Select root as user and set password
# Close connection
# Enter password and use connection as usual


##################################################################################################################################
#                                                   Connecting MYSQL to R
##################################################################################################################################

# For MySQLWorkbench dbname will be the name of your schema NOT your database connection
# DO NOT CHANGE host, port, or user unless you intentionally changed those variables when creating your db
# If you set a password input your password, otherwise leave delete the parameter
mysqlconnection = dbConnect(RMySQL::MySQL(),
                            dbname='lecture',
                            host='localhost',
                            port=3306,
                            user='root',
                            password='Cmsc389ePassword_!')
# Shows all tables in schema
dbListTables(mysqlconnection)
# Allows you to pull a query using the sql connection
# If you use double quotes in your query, convert them to single quotes to prevent errors
query = "
With T1 as (
	select work_year, experience_level, job_title, salary, 
			case when salary <= 50000 then 'level 1'
			when salary > 50000 and salary <= 100000 then 'level 2'
			when salary > 100000 and salary <= 250000 then 'level 3'
			else 'level 4'
			end as 'salary level'
		from salariesv3
), T2 as (
	select concat_ws(', ', work_year, experience_level, job_title) as title, salary, `salary level`
	from T1
)
select *, substr(title, 10) as substr_ex, UPPER(`salary level`) as uppercase_ex, character_length(title) as char_len_ex, 
find_in_set('EN', title) ind_in_title_ex, format(salary, 'N') as format_ex, replace(`salary level`, 'level', 'range') as replace_ex
from T2;

select * from airbnbdata
"

result = dbSendQuery(mysqlconnection, query) 
# Stores resulting table as dataframe
df = fetch(result)
print(df)
