+++
title = "Is NIH really so bad?"
date = 2010-03-02
in_search_index = true
[taxonomies]
tags = [
	"clojure",
	"molehill",
	"nih",
	"web-framework",
]
+++
This site is now powered using molehill. I say this because for one it's nice to announce this sort of stuff and two because it leads into the main content of the article. Molehill is a static site generator and commandline content management system. It uses vcs to track changes and can build a site from files containing content on a filesystem. Because molehill is a site generator and not a web application it doesn't serve files up as part of it's normal operation. But while developing the application I found myself wishing I could temporarily serve the content from a server to see what it looks like and behaves like in that environment. So I needed an embedded webserver. Since this wasn't meant for heavy extended use and mostly only for testing a molehill site I didn't want anything fancy or complicated to use. My requirements were simple.

   1. It had to serve content from a directory
   2. It had to allow you to specify the port
   3. It shouldn't require a lot of dependencies
   4. It shouldn't be hard to add.

Now Molehill is written in clojure, which means theoretically it has access to all the wonderful libraries java has accumulated over the years. So finding a small simple embedded webserver should be easy right? I looked at:

   1. Jetty (not easy to setup or use)
   2.  BareHTTP (looked like it did what I needed but the code didn't actually work)
   3. Commanche (not easy to setup or use)

Finally I found a less than 100 line clojure gist on github that did exactly what I needed. When I twittered about the find and my frustration looking for a java option I received responses ranging from = ""Cool that didn't take long" to "Why are you so down on Jetty?" The latter opinion seemed to be that Jetty was fine so why invent another solution. One said I was crazy since his production jetty xml config file was only 50 lines long. Keep in mind that I was wanting to launch this from commandline with only a single command line parameter, the port, for configuration. I certainly didn't want to have to write an xml file every time I started a new site. Why put the user through that? Granted I could probably have programmatically configured the Jetty server using clojure code and not needed the file, but again why should I have to? In my mind the extra dependency, lack of simplicity, and general uckiness of using jetty for this wasn't a good fit. What I needed was something that fit in a single clojure file had no dependencies and did simple webserving. For that the github gist was exactly what I needed. It improved things for the user and the coder and in my mind thats a win win."

I agree that trying to invent everything yourself can be prohibitively time consuming and fraught with unexpected problems. Spending a little time looking for something that has already solved your particular problem is a good investment. But making it a religious belief can be just as prohibitive. Jetty is very good as an embeded java http servlet container and server. It does a fantastic job at this and if you need that in your app it's a lightweight way to go. But if you all you want is a temporary static site server with only two configuration options then jetty suddenly gets in your way. Sometimes the only solution is your own solution and that's ok. So the next time someone announces they had to build something because your favourite library/application/tool didn't do what they needed don't yell at them. Congratulate them on finding an unfullfilled need and wish them luck in their endeavor. It might not be NIH It might instead be NIY (Not Invented Yet) and you just didn't realize it.
