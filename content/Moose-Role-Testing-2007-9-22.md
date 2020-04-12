+++
title = "Moose::Role Testing"
date = 2007-09-22T05:28:23
in_search_index = true
[taxonomies]
tags = [
"Site-News",
]
+++
Currently there is no simple way to test Moose::Roles. Since they defer things like attribute adding and method wrapping you have to create a dummy class that uses them to test what they do. Usually this is through creating a package inline in the test module that does what you need or don't need based on what your testing. Therefore I'm considering either adding Role support to Test::Moose or creating a Test::Moose::MockObject module to make this easier. Still trying to decide which way to go. Maybe I'll go both ways :-)
