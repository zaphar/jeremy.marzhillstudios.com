+++
title = "SQL stupidity"
date = 2005-08-25T04:03:39Z
in_search_index = true

[taxonomies]
tags = [
	"ANSI-SQL",
	"Data",
	"Software-Development",
]
+++
Let me let you in on a secret. SQL is a great language for getting information out of a database. But if your writing a long string of stored procedures that call functions which use a view that ties several tables together just to find out what particular piece of data is linked to your piece of data then you need a good talking too. Not only does all this unnecessary complexity make debugging hard for you. But it makes folks like me want to beat you up with a baseball bat. So do us all a favor. See if you can reduce the number of steps and keep the squirming pathway a little straighter. Then you can scream and rant and pummel the brains out of your fellow coders (who didn't heed this warning) with the rest of us.
