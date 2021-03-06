+++
title = "Perl Tip - Chained encodings and binmode magic"
date = 2006-10-07T14:42:04Z
in_search_index = true
[taxonomies]
tags = [ 
	"Perl",
	"Software-Development",
]
+++
OK how many of you have gotten those Wide Character in Print warnings while dealing with unicode text? especially UTF-16 files which don't get handled on the fly in perl. I finally figured out how to get rid of them thanks to, of all places, a <a href="http://blogs.msdn.com/brettsh/archive/2006/06/07/620986.aspx">MSDN blog</a>. The gist of the post is a technique where you chain encodings together when changing the encoding used on a file handle. He used it on an open but for my purposes I wanted to change STDOUT's encoding not an opened file handle. So heres the magic line = "binmode(STDOUT, ":raw:encoding(UTF-16):utf8"); Now your first thought is why couldn't you just use the encoding you want? Well here's why. First of all the utf8 encoding on the righmost tells perl that it is receiving it's default utf8 encoding. Then the encoding(UTF-16) in the middle performs the encoding conversion and finally the raw on the left tells perl to spit it out whithout changing. The three together result in a warningless conversion from utf8 to utf16 with no line feed conversion. I didn't even know you could chain these together until now but I'm going to remember this trick for the future, that's for sure. To break it all down for you. The chain is processed from right to left. Starting with utf8 got rid of my wide character warning. chaining that into the encoding(UTF-16) performed my conversion and chaining that into :raw made sure I got text and not octet encoded characters."
