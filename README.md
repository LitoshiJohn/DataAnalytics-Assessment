This will serve as proof of my thought process for each question.

Q1.
-The first thing I note is that only customers with both savings AND investment plans are wanted.
-The minimum number of plans must be 1 (showing that they have an active plan, savings>= 1 & investment>= 1)
-I would therefore place a filter to remove accounts with one of the required plane.
-Divide the confirmed_amount by 100 to get the value in Naira.
-I write a simple SELECT * query to look at the data in each of the necessary tables.
-I'll use owner_id & id to join the tables since they are the same.
-Use CONCAT to join the first and last names of the users.
-organise the expected output and what table they fall under.
-Use Rank to remove duplicate results. (First iteration returned 600k+ results, with many duplicates, rank only returned the first one and eliminated the rest)
-Use CTEs to breakdown the query and organise my thoughts better.

Q2.
-Frequency based on average transactions per month.
-I'll use CTEs again to organise my work.
-The base CTE has all the columns needed for the query and that's where I apply all my filters and groups.
- I sum the transactions for each user. (count the transaction references since each reference is unique).
-The eggs CTE has more aggregate data. I use a timediff function to get the number of months a user has had an account(subtract the current date month from the month they joined)
-I divide the transactions by the timediff to get the average number of transactions per month for each user.
-A separate CTE is needed for the frequencies.
-I would use a CASE statement to define the ranges for each frequency.
-fir the final statement, count the users and take an average of the transactions per month of every user in each category. Group by the frequency.
-I used Transactions/Months as a more accurate measure of the average transactions per month.

Q3.
-For ACTIVE accounts with no transaction in the last 1 year, they must not be archived, deleted or deleted from groups.
-Look for transaction dates older than 365 days (txn date > 365)
-Only look at Savings and Investment accounts, per the question.
-To ensure the last transaction is older than a year, I will use the MAX aggregate function in the transaction date column. This will give the last transaction and the filter tx date > 365 is applied here.
-Filter only for successful transactions.
-To count inactivity days, I'd need to get the difference in time between the last transaction date and the current date.
-As per the previous questions, I lay out the expected output and identify what tables are necessary for each of them.

Q4.
-Customer Lifetime Value has a formula, so I will break the query into various CTEs. This will give a very structured flow to the query 
-What is CLV? = (total transactions/months)*12*(confirmed amount/100)*(0.1/100). Confirmed amount is divided by 100 to get the Naira value.
-The confirmed amount is aimed per owner_id which is renamed to customer_id.
-Outline the expected output and the tables they can be gotten from.
-CONCAT user first and last names.
-Get the monthly timediff between the date joined and the current date.
-Count transaction references as total transactions.
-Divide the total transactions by the tenure to get the transactions per tenure.
-In the proceeding CTE, use the formula above to obtain the estimated clv.
-Final statement will contain all data from the last CTE.
-Filters are applied in the first CTE, this makes the query faster by only fetching the needed data.


Challenges faced

I did face 1 challenge. My SQL experience has evolved around Blockchain analytics, using Snowflake SQL for Flipside Crypto and Postgre SQL for Dune Analytics. Switching to MySQL was a bit challenging in the way queries are written. Certain statements I wrote were not suited for MySQL.

To overcome the challenge, I'd use an AI chat bot to review any line of the query that was not suited to MySQL. I'll be taking a Udemy course or watch some YouTube videos on MySQL to   build my knowledge of MySQL.

Thank you.