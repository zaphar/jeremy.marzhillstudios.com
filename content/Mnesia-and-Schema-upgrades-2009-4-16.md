+++
title = "Mnesia and Schema upgrades."
date = 2009-04-16T19:41:41Z
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"databases",
	"erlang",
	"mnesia",
	"upgrades",
]
+++
I had an epiphany or sorts the other day. While working on iterate I realized that I was going to need to upgrade the schema of my mnesia tables. Schema changes on databases often mean bringing down the application. At least they usually have in my experience anyway. I hate to upgrade databases. That is I did until I met erlang and mnesia. The issue is that my mnesia schema for some tables was using a user provided name for the primary key. This was fine while it was just a prototype but now it was time for it to grow up. The record describing the table had to change and all the records in a table had to change. Now no one is really using this right now so I had a choice. <ul> <li>Blow away the database and rebuild it.</li> <li>Be all erlang'y and stuff and do it live.</li> </ul> Wait a minute did he just say "live"? You can't update the schema and convert all the records live. That's crazy! Ahhh but this is erlang we do things different here. Witness the glory of iterate's db_migrate_tools:
<script src="http://gist.github.com/96772.js?file=minihttpd.clj"></script>
Notice, the transform_stories function. It defines an anonymous fun it uses to transform the mnesia table with. Currently this function only has one signature. There is no reason it can't have more thoug. Since, erlang allows multiple signatures for anonymous functions, I can specify a signature for the next version of the mnesia table if/when it changes again. Here's the epiphany part. I can keep updating that fun with more signatures for each version of the table. Theoretically ,if I were to end up with a table that had records of multiple different historical types in it, I would be able to use this one transform function to get them all updated to the new record type. And I can do this all live without taking down the database or app. I can ship each iterate version with a module capable of updating the database live from any previous version. Now that's power that's useful. Try doing that with another platform. 
