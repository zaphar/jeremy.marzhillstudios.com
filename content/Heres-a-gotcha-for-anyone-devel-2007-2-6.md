+++
title = "Here's a gotcha for anyone developing with mod_perl and APR"
date = 2007-02-06T01:31:29
in_search_index = true
[taxonomies]
tags = [
    "Site-News",
]
+++
I had a mod perl handler that was mapped to different URL's. One worked as expected the other URL did not. Exact same code Everything was hard coded for testing so the URL had no bearing whatsoever on the code. So why on earth would one URL have an error and the other not? It took me a while but I finally figured it out. What else could have been different about the two different URL's besides the URL itself? The answer? Cookies. Specifically in this case cookies put stored by Wordpress on this particular domain. More specifically a cookie with comma's which counts as a malformed cookie and just so happens to crash Apache2::Cookie every time. Since I couldn't count on the cookie not coming back I decided to implement a workaround. So the next time you build something for the web on modperl2 using Apache2::Cookie you might just want to preprocess the Cookie header before trying to pull cookies out of it. I wrote a simple function that split the cookies out of the header removed the comma, semicolon, and any whitespace from the cookie value and then overwrote the Cookie headers before trying to retrieve the cookies. You can't always assume that the cookies you see come in are cookies you set. Cross domain cookies and Cookies used by other apps in your domain name space may be a source of trouble if you aren't careful. I learned this the hard way but at least it was on a testbed site and not something for production. Related Links = "<a href="http://trac.wordpress.org/ticket/2660">Wordpress Ticket</a>"
