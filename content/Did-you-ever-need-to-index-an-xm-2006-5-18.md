+++
title = "Did you ever need to index an xml doc"
date = 2006-05-18T16:26:57
in_search_index = true
[taxonomies]
tags = [
	"Data",
	"Languages",
	"Perl",
	"Software-Development",
	"XML",
]
+++
and preserve the xml information in the index? May I present "<a href="http://jeremy.marzhillstudios.com/personal/xml_indexer.zip">the XML Indexer</a>". My brother, who's very populer <a href="http://www.walljm.com/bible/">AJAX Bible app</a> has been getting attention, needed an xml index of the KJV Bible. He asked if I could help him get it. We would be parsing the KJV in XML format and I needed to pull out the reference information for every occurence of every word. Well I thought an xml indexer might be useful in more than one capacity and there wasn't much on the net or cpan with the capability to do it. It needed to be light and fast because it was going to be parsing the entire bible so a DOM parser was out of the question. So I wrote my own. xml_indexer.pm is a module to index the words in an xml document and preserve the xml information about each occurence of the word. It's a little rough around the edges right now but it works. It uses the expat parser so it's light and fast. Look at the bible_index.pl script for an example of how it works. I'll do a tutorial on it later. <strong>Update:</strong> This baby has been confirmed to parse the entire bible in Zaphania xml format in under 3 minutes. That is a 16 MB file. It spits out a 23 MB index in that space of time. Quite honestly it surprised me. 
