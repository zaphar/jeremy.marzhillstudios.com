+++
title = "SOAP or the lack thereof"
date = 2006-10-27T14:50:44Z
in_search_index = true
[taxonomies]
tags = [
    "Site-News",
]
+++
My first professional experience with pulling data via a Soap Service has proven to be very disappointing. I am fairly sure that SOAP services work very well as long as the company providing them knows what they are doing. This company does not appear to know what they are doing. So for future reference when providing a SOAP Service to someone please include in your description of how to hit it the following items = "Namespace URL complete Object description for the call Then don't change these under any circumstances. Don't assume that the people using your Service are going to be using .NET on the client side. The whole point of SOAP is cross platform RPC calls. If your system won't work out of the box with Java or Perl or python clients then you didn't set it up right. Anyway I'm done ranting now. Maybe this next time they will get it right."
