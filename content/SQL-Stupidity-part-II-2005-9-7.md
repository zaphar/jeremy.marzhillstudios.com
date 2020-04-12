+++
title = "SQL Stupidity part II"
date = 2005-09-07T21:31:35Z
in_search_index = true

[taxonomies]
tags = [
	"ANSI-SQL",
	"Data",
	"Software-Development",
]
+++
I am working on a legacy web application right now that is giving me fits. I'd say about 90% or so of the application is done in SQL. Yes you got that right. The business logic is almost completely written in a huge number of stored procedures, sql functions, and scheduled database tasks. This makes tracking down the parts of your app you are trying to work on very difficult. Every time I turn around there is another stored procedure, function, or scheduled database task that needs tweaking. I'm starting to go a little crazy. The problem is it obfuscates what your application is really doing. You think a perl obfuscation contest produces difficult to follow code? They got nothing on this. I realize stored procedures were the cat's meow at the time but this is beyond all human decency. I have got to start refactoring this thing before it gets out of control.
