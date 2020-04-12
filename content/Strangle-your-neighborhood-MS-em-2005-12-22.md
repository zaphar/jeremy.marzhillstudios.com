+++
title = "Strangle your neighborhood MS employee"
date = 2005-12-22T15:05:13
in_search_index = true

[taxonomies]
tags = [
"Site-News",
]
+++
Do the world a favor, the next M$ employee you meet don't hesitate, don't think... Just strangle the life out of him. I'm so angry right now, I could kill someone. Anyone ever tried to switch SSL certificate providers on an IIS server? Your better off switching servers. To top it off, the provider we were switching to told me Microsoft won't let them link to the knowledgebase article that walks you through it. In effect, they won't allow the Certificate authority to give instructions on the proper method. So, I'm going to tell you, now that I know. You can't generate a CSR on IIS without getting rid of your old certificate for the site. This means you have either the option of being without a certificate for the 1-7 days it takes to get a new certificate or you don't get a new certificate and just renew the old one with the current provider. Not an option for my customer. Even a day with no certificate would cause significant problems. So you have to work around it. In effect, you have two choices. Actually, they are work-arounds to a "bug" that microsoft calls a "feature." You can create a dummy server to generate the request on. Then, once you have your certificate, you can export it for use on your real server. Or, option number two, create a dummy site on the real server, use it to generate your CSR, and then import the certificate into the real site. Either way, you have to do extra steps that aren't immediately obvious because Microsoft made crummy design decisions for their software. And people wonder why I prefer Open Source.
