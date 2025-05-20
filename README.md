This will serve as proof of my thoughts process for each question.

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
-Tge base CTE has all the columns needed for the query and that's where I apply all my filters 