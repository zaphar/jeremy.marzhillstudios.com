+++
title = "Coding Agents and Organizational Impacts"
date = "2026-06-01"
in_search_index = true
[taxonomies]
tags = [
    "engineering-management",
    "ai",
    "agentic-coding",
    "essay",
]
+++
# Coding Agents and Organizational Impacts

## Introduction

Unless you have been living under a rock over the last year you are probably
aware that AI agents have taken the software industry by storm. It has become
clear that a coding agent can deliver software to varying levels of quality in
timelines that are accelerated compared to what your average developer could
deliver. It's not a magic bullet for speed or quality but it can be a useful
tool and it's not likely to go away. Regardless of what you think about these
things they are going to be a part of the job for the foreseeable future.

This essay is not going to go talk about how to get the best results from a
coding agent or opine on the level of quality they produce. I have opinions
on these things but that will probably have to wait for a later essay. This
one is an attempt to forecast the impact of these tools on software development
teams, and how those impacts will affect an organization's ability to scale
their usage.

## Team collaboration as a limiter on speed

Before agents came along we knew that collaboration and coordination was a
major time sink of engineering teams. Most developers didn't spend 8 hours a
day 40 hours a week typing into an editor. They discussed architecture, hunted
down requirements, UI mocks or wireframes for that feature they needed to get
done or reviewed their colleagues' code and sought out code review for theirs.
The larger the team supporting a product the more communication overhead they
experienced. This overhead was necessary to ensure that everyone was moving
in the same direction. They had the same standards for the code and architecture.
They were solving the same product problems. They followed the same UI standards.

An agent can produce code that compiles and runs for some set of happy paths
much faster than a human dev can. This means they will, without coordination,
entice a dev or a team to keep pushing on. *Just one more feature... honest.*
This tendency introduces a risk that the team will start
fragmenting the codebase and the various approaches over time. The longer the
dev + agent goes without touching base with the rest of the team the higher the
risk that the code will go astray and need fixing up. The fix is to speed up
the cadence of collaboration to keep up. Agents add communication overhead more
than they reduce it. The amount a team needs to coordinate is mostly set by the
work itself, not by how fast anyone can type. What agents change is how quickly
that work turns into code, and how much of it each dev and their agent decide on
their own before anyone else has a say. So you don't end up with less to
coordinate. You end up with more of it already built, in directions that don't
line up, before anyone has talked. Untangling that after the fact costs more
than it would have to stay in sync as you went. Instead of Janet and George getting on the same
page it is now Janet's agent, Janet, George, and George's agents all getting
on the same page. In my own experiments this overhead only grows the more people
you introduce. At some point the coordination becomes a hard limit on how fast
you can go. This is not to say that agents won't increase your velocity. They do.
But it is at the cost of higher collaboration and communication overhead.

## Agents have distinctly average to poor design and architecture instincts

Part of why teams diverge like this is the agent itself. Out of the box a coding
agent is unlikely to have good taste when it comes to the architecture of your
system. They are very much the average of opinions of the public internet's
discourse on good system design. As a result their opinions are usually wrong
but not obviously so. Further complicating it is that many of your developers
will have varying opinions on the subject, not all of them agreeing, and they
will steer the agent with those opinions. Sometimes intentionally and sometimes
just from the way they structure their requests. The result is that no two devs
with an agent are going to produce code with the same architectural guiding
principles. You can't encode enough of that into your system prompts to make
that happen. Getting good results means you need code review against a documented
standard and frequent coordination between your devs and the product team.

## Impact isn't understood until the artifacts exist

A lot of design and architecture decisions can't really be judged until the
code exists. You can argue about an approach in the abstract for hours and still
not know whether it holds up until you've actually built it. Building it used to
be slow, and that slowness was its own kind of safety net. You'd find out an
approach was wrong gradually, while you'd only committed a little to it, and you
could adjust course on the fly without much risk. Agents made building nearly
free, so now the cheapest way to find out if an idea works is to just have the
agent build the whole thing.

For one person poking at an idea on their own, that's mostly a good thing. The
trouble is that every one of those explorations lands as an artifact someone
else has to read, understand, and reconcile with everything around it. The loop
is addictive, and a lot of developers are solitary by nature anyway. They will
easily rearchitect half the application and land a -2000, +4000 edit change in a
PR for someone to review without even realizing it. They may only have spent a
week on it, but it may be a week of lost work and wasted token spend because the
PR went in a direction the tech lead happens to know won't work. Building got
cheap. Understanding what got built didn't.

## The workflow loop is a slot machine

The startup cost for a new feature, bug fix, or refactor for that new idea you
had with an agent is remarkably low. Without even realizing it, your team
members can find themselves churning out code they barely understand, going back
and forth with the agent, feeling productive but massively disconnected from
what they are producing. Like any good slot machine the reward is unpredictable.
Sometimes you pull the lever and get exactly what you wanted, sometimes you get
garbage, and that uncertainty is what keeps you pulling. There is no obvious
offramp from the work. The machine never tells you to stop, and the perfect
feature always feels like just a few more tokens away. This creates a high risk
for burnout.

The machine has a second way of getting you. The moment you slow down to
question what it produced, push back, or ask for changes, you start to feel like
you are the roadblock. The machine is fast, and
you, with all your opinions and questions, are what's slowing it down. So you're
tempted to just give the agent full freedom and get out of its way. Never mind
that those opinions and questions are the actual value you bring.

## Humans are bad at multi-tasking

There is a strong temptation to celebrate or encourage people working on 5
different things using 10 agents at once, constantly switching back and forth to
keep all the agents busy. It feels like a huge multiplier but it isn't one. The
thing that actually limits you was never how fast the code gets written, it's
how much of it one person can pay real attention to, and that part doesn't get
any bigger no matter how many agents you add.

An agent will happily sit and wait while you go look at another one. You never
get a natural brake limiting your activity. No one is good at keeping that much
state coherent in their head, and every time you switch you pay the cost of
loading it all back in, you just don't notice you're paying it. They may feel
productive while the attention they can give any one agent quietly drops below
what it takes to catch the things it gets wrong.

The agents really are working in parallel. That part isn't an illusion. The
catch is that all of that work has to come back together through one person, and
that person is you. You are the point everything has to synchronize through, and
the place it shows the strain first is the back and forth between you and each
agent. You can only really take in what one of them is telling you at a time, so
the more agents you run the less of each conversation actually lands. The code
keeps coming but less and less of it is actually getting looked at. Quality goes
down, the divergence and communication problems from earlier only get worse, and
burnout is just around the corner for any team doing this long term.

## Agents crowd out communication

You've probably been the recipient of a massive wall of text from someone that
used an LLM to generate it. They want you to read it and give feedback or
respond or take action in some way. The prose however is overly long and
ingratiating. The last thing you want to do is try to read and understand it.
You probably fed it to an agent so that agent could summarize it for you.
Before you know it your entire team has stopped thinking. They are just a
glorified messenger service for each other's agents.

The trouble is that the thinking was never separate from the writing and
reading. Working out how to say something clearly is how you figure out what you
actually think, and reading someone's attempt is how you actually engage with
what they mean. When one agent writes the message and another agent reads it the
words still get from one person to the other, but the understanding that used to
come with them never forms on either end. The communication still happens. The
thinking it was supposed to carry quietly drops out.

# Strategies

So what do you actually do about all of this? None of these risks are a reason
to avoid agents. The teams that come out ahead will be the ones that see them
coming and build their habits around them. They will end up ahead on both the
quality and the quantity of what they ship.

Most of it comes down to engagement. Choose tooling and approaches that pull
your people toward the work the agent is doing instead of letting them drift
away from it. Instead of using an agent to generate a wall of text, tell it the
message has to fit in a paragraph of fewer than ten sentences, so a human still
has to decide what actually matters. Keep the units of work small enough that
someone can hold them in their head and actually review them, and get feedback
early and often. That might stretch a week of work into a week and a half, and
the speed won't look quite as impressive, but the output won't be wasted. The
feedback that matters most still comes from other people. Talking to an agent is
not a substitute for talking to your tech lead.

Because no two devs and their agents will land on the same architecture on their
own, you have to give them something to converge on. Write down the standards
you actually care about, the architectural ones as much as the stylistic ones,
and review code against that standard instead of against whatever each agent
happened to produce. Pair that with frequent coordination between your devs and
the product team so everyone is steering toward the same place. The agent won't
find the shape of your system for you, so the humans have to own it.

Be careful about how much you ask any one person to run at once. One developer
shepherding ten agents across five different features is probably an
anti-practice, not a thing to celebrate. And because the work no longer stops on
its own, you have to build the stops in yourself. The lever is always there to
pull, so decide ahead of time where the offramps are and make it normal for
people to take them. Protecting your team from the machine that never tells them
to stop is part of the job now.
