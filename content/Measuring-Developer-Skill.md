+++
title = "Measuring Developer Skill"
author = "Jeremy Wall"
date = 2020-04-12
draft = true
in_search_index = true
[taxonomies]
tags = [
	"measurement",
	"skill",
	"developers",
	"hiring",
]
+++
Measuring Developer Skill
=========================

A recent article about a pycon keynote by Jacob Kaplan Moss brought an
interesting question to my attention.  How exactly would one measure
developer skill. It's interesting because the question itself is hard
to define properly. For one thing there are a lot of dimensions to
measure skill in. And developers hold many different roles in a team.
DevOps, Architects, Maintainers, BugFixers, Automators. Each of these
requires different skillsets. My brother who is also a developer made
the comment that skill measurements are useless without an
expectation. Against what benchmark are we measuring the skill?

I'm not at all sure there is any answer to this question that even makes
sense. But perhaps we can make some useful progress if we narrow the scope
a little.

What if we just tackled the question of API design?

Measuring a single dimension of coding skill.
---------------------

API quality is one dimension on which you could measure developer
skill. For a measurement of API quality to be useful though it has to
be more than some elusive abstract idea of elegance or beauty
though. What would make a truly useful measurement of API quality?

When designing an API one of the commonly held goals is the principle
of least surprise.  You want to build an API that makes sense to the
user and isn't bewildering in it's behavior.  This seems like it
should somehow be measurable right? But how do you measure how
"surprising" an api is?

Another commonly held goal is the to reduce complexity. An API's
purpose is to hide a lot of the complexity in a problem and make it
comprehensible to the user.

Both of these ideas at there core are centered around the concept of ease of use.
What we need is a way of quantifying Ease of Use in a measurable form.

# WTF/dev/day #

Really the reason we care about ease of use is because it reduces
frustration when we consume an API. So the *number* we are trying to
reduce is the count of WTF's devs encounter when working with an
API. We could simply measure how many times a developer encounters a
WTF when using an API. But this is of course inherently biased.  We
need a way to control or reduce that bias if we care about creating a
measurement that is useful to an industry.

What factors do we need to control for in a measurement of coding skill?
------------------

Assuming we are measuring in a single dimension we are going to have to decide
exactly what factors are important and what factors should be controlled for in
our measurements.

People with stockholm syndrome are obviously going to experience less
wtf's per day than someone new to an API. The quality of the API's
documentation also affects the wtf count. Which brings up a
question. Is the documenation a part of the API?  should it be a
factor in our measurement or should it be restricted to code alone?

We will encounter hundreds of these factors for any dimension we
attempt to measure. Collecting useful data here is a hard problem.