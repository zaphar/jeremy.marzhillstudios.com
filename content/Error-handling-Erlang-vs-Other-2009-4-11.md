+++
title = "Error handling (Erlang vs Other languages)"
date = 2009-04-11T09:59:12Z
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"best-practices",
	"coding",
	"erlang",
	"functional-programming",
]
+++
When I'm in Perl, Javascript, Java, or any other programming language I prefer to throw exceptions rather than return errors. This is because I've long since gotten tired of losing errors 5 calls deep in the code because I forgot to check the return and handle it. Nothing is more annoying than trying to debug a problem that is actually caused somewhere else, but you don't know because the error vanished into the that Great Heap in the Sky around about 5 calls down. You've been there before. That's when you start adding print statements followed by an exit or, if your lucky enough to have one, firing up the debugger and using break statements to narrow down the actual source of the problem. This process could take days depending on how far removed from the breaking code the actual problem is. In erlang, however, returning errors actually turns out to be useful. This is because in erlang returning errors actually has the desired effect. Usually, when you return errors in an app, it is because you don't want to kill the whole program when something breaks. What you intend is for the caller to inspect the return and do the appropriate thing. This however runs smack into the whole <blockquote>programmers are fallible people, who sometimes stay up late coding at 3am, when they can hardly see the screen anymore</blockquote> problem. In short you are depending on the caller to honor your contract and do the right thing even though we often do exactly the wrong thing. Even when you are the caller, sometimes you don't honor that contract. Then a month later you are doing that print statement and die or perhaps the debugger dance again. All of this because of one night when your judgement lapsed. Companies will often develop elaborate style guides, testing strategy, and code-review cultures to prevent this, but in the end most developers I know come to love throwing exceptions... unless they are coding in erlang. This is because of two elements of the erlang language design = "<ul> <li>Pattern Matching</li> <li>and Fail Fast.</li> </ul> In erlang returning errors <strong>requires</strong> the caller to handle them. If I try to store the return of a function and it doesn't match what I told it to expect then <strong>bang,</strong> an automatic exception. However, if I try to store the return and explicitely handle the error case then no exception is thrown. This has the wonderful effect of forcing me to think about exactly what I expect this function to return, and handling or ignoring at my choice. The big benefit is that I had to think about it. The below example illustrates the difference."
<script src="http://gist.github.com/93574.js?file=minihttpd.clj"></script>
The combination of Pattern Matching and Fail Fast in erlang forces the programmer to honor the contract, whether he wants to or not. This is one case where Erlang follows the "Do What I Need Not What I Want" principle in a language properly.
