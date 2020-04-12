+++
title = "erlang datetime utility functions"
date = 2009-05-01T01:17:21
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"datetime",
	"erlang",
	"utility-functions",
]
+++
I have been doing some work on timeseries data in erlang for iterate graphs and
found the calendar module in stdlib to be lacking in some useful features.
So being the helpful hacker I am I created a utility module to wrap calendar
and be a little more userfriendly. May I present date_util.erl:
<script src="http://gist.github.com/104903.js?file=minihttpd.clj">
