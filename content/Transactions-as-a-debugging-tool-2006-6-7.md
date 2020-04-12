+++
title = "Transactions as a debugging tool"
date = 2006-06-07T14:13:13Z
in_search_index = true
[taxonomies]
tags = [ 
	"ANSI-SQL",
	"Data",
	"Software-Development",
]
+++
Have you ever wanted to test a long sql DDL script for syntax errors but didn't want to actually create your db structure yet? I've found the easiest way to do this is through the use of transactions. simply begin a transaction at the start of the script and roll it back at the end of the script. For example = "<code syntax=sql>"
-- PostgreSQL DDL script
BEGIN;
  -- begins our transaction block
  CREATE TABLE test_tbl ( pk numeric NOT NULL, data varchar(128), );
ROLLBACK; -- roll back everything this script just did
COMMIT; -- use this instead of ROLLBACK to commit the changes
</code> This has the benefit of allowing us to test the script for errors and yet not actually run it on the DB. The EXPLAIN command can do this also on some DB's but you would need it for every statement you wrote in the script and some statements will error out if you use EXPLAIN on them. I've found the Transaction method to work best for what I want to do.
