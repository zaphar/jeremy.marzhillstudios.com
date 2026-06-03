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

<!-- OUTLINE / DRAFT -->

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
teams, and how those impacts will affect an organizations ability to scale
their usage.

<!--
- Most of the conversation about agentic coding is about individual productivity. Less attention is going to what it does at the team and organization level — which is where I think the harder questions actually are.
- Thesis: a lot of what kept teams aligned and code healthy came from friction we never had to think about — the pace of work, the cost of starting something, the fact that someone had to read what got written. Agents reduce that friction dramatically. That's genuinely valuable, and it also quietly removes things that were doing real work for us.
- This isn't a case against agents. It's an attempt to name the second-order effects so we can decide what to do about them on purpose.
-->

## Team collaboration as a limiter on speed

Before agents came along we knew that collaboration and coordination was a
major time sink of engineering teams. Most developers didn't spend 8 hours a
day 40 days a week typing into an editor. They discussed architecture, hunted
down requirements, UI mocks or wireframes for that feature they needed to get
done or reviewed their colleagues code and sought out code review for theirs.
The larger the team supporting a product the more communication overhead they
experienced. This overhead was necessary to ensure that everyone was moving
in the same direction. They had the same standards for the code and architecture.
They were solving the same product problems. They followed the same UI standards.

An agent can produce code that compiles and runs for some set of happy paths
much faster than an human dev can. This means they will without coordination
entice a dev or a team to keep pushing on. Just one more feature, bro. Look how
productive we are! This tendency introduces a risk that the team will start
fragmenting the codebase and the various approaches over time. The longer the
dev + agent goes without touching base with the rest of the team the higher the
risk that the code will go astray and need fixing up. The fix is to speed up
the cadence of collaboration to keep up. Agents add communication overhead more
than they reduce it though. Instead of Janet and George getting on the same
page it is now Janet's agent, Janets, George, and George's agents all getting
on the same page. In my own experiments this overhead only grows the more people
you introduce. At some point the coordination becomes a hard limit on how fast
you can go. This is not say that agent's won't increase your velocity. They do.
But it is at the cost of higher collaboration and communication overhead.

<!--
- The size and speed of agent-generated change leaves more room for team divergence.
- When everyone can move fast in their own direction, the implicit coordination that used to happen naturally (slower pace = more chances to align) erodes.
- *(Expand: what mechanisms used to keep teams converged, and which of them break under agent speed.)*
- The more unmonitored work an agent does, the harder it becomes to maintain quality.
- Quality is a function of attention; agents decouple output volume from human attention.
- *(Expand: where the attention has to go instead — review, design, intent.)*
-->

## Impact isn't understood until the artifacts exist

Core to this limit is that a coding agent will naturally push a developer to
doing larger bodies of work without getting feedback first. The loop is
addictive and roughly about half of your developers are probably already
naturally solitary creatures. They will easily rearchitect half the application
and land a -2000, +4000 edit change in a PR for someone to review without even
realizing it. They may only have spent a week on it but it may be a week of
lost work and wasted token spend because the PR went in a direction that the
tech lead happens to know won't work. Getting early and frequent feedback might
turn that week into a week and half instead with considerable overhead and the
speed won't look quite as impressive but the output won't be wasted.

<!--
- Many design and architecture choices' impacts are not fully understood until the code is created.
- Unifying a team of diverging agents is going to incur communication overhead and/or rework.
- *(Expand: the "explore by building" loop, and why that's expensive to reconcile across multiple agents/people.)*
-->

### Agents have distinctly average to poor design and architecture instincts

Out of the box a coding agent is unlikely to have good taste when it comes to
the architecture of your system. They are very much the average of opinions of
the public internet's discourse on good system design. As a result their
opinions are usually wrong but not obviously so. Further complicating it is
that many of your developers will have varying opinions on the subject not all
of the agreeing and they will steer the agent with those opinions. Sometimes
intentionally and sometimes just from they way they structure their requests.
The result is that no two devs with an agent are going to produce code with the
same architectural guiding principles. You can't encode enough of that into
your system prompts to make that happen. Getting good results means you need
code review against a documented standard and frequent coordination between
your devs and the product team.

<!--
- This is further complicated by the fact that an agent has poor design and architecture instincts.
- The human still has to own the shape of the system; the agent won't reliably find it.
-->

## The workflow loop is a slot machine

The startup cost for a new feature bug fix or refactor for that new idea you
had with an agent is remarkably low. Without even realizing it your team
members can find themselves on a treadmill churning out code they barely
understand. Going back and forth with the agent feeling productive but also
massively disconnected from what they are producing. This creates a high risk
for burnout. There is no obvious offramp from the work. You pull the lever code
comes out and your just a few more tokens away from the perfect feature.

<!--
- The next bug / feature / refactor startup cost is so low that burnout is a very high risk.
- With no natural friction between tasks, there's no built-in recovery; the work never has to stop.
- *(Expand: what guardrails individuals and orgs need to protect against this.)*
-->

If you try to force yourself to be engaged with the actual results of the
process you find yourself fighting the system. There is a massive temptation to
give the agent full freedom so it can go even faster. You start to feel as you
yourself are the roadblack with all your opinions/questions and feedback. Never
mind that those are the actual value you bring to the process.

<!--
- There is a persistent temptation to bail out early and give the agent full freedom.
- Why this is seductive and why it's a trap — it trades short-term ease for the divergence/rework costs above.
-->

## Humans are bad at multi-tasking

There is a strong tempation to celebrate or encourage people working on 5
different things using 10 agents at once. Constantly switching back and forth
between them keeping all the agents busy. No one is good at keeping that much
state coherent in their head. They may feel productive but they'll also be
running at full tilt non-stop which is not healthy and is also known to result
in degraded performance over time. Slowly they'll fail to catch things the
agent does and quality will go down. This only exacerbates your communication
problem too. Burnout is just around the corner for any team doing this long
term.

## Agents crowd out communication

You've probably been the recipient of a massive wall of text from someone that
used an LLM to generate it. They want you to read it and give feedback or
respond or take action in some way. The prose however is overly long and
ingratiating. The last thing you want to do is try to read and understand it.
You probably fed it to an agent so that agent could summarize it for you.
Before you know it your entire team has stopped thinking. They are just a
glorified messenger service for each others agents. Agent's are terrible at
clearly and concisely helping you communicate and think about the work they are
doing.


<!--
- By themselves, agents will crowd out the space for thought.
- The constant availability of "just have the agent do it" displaces the slower thinking that good engineering depends on.
-->

# Strategies

So how do you support your teams in navigating this massive industry change? Recognizing
the risks and mitigating them will help your team stand out from the crowd in both
the quality of their output as well as the quantity of that output.

Choose tooling and approaches that increase engagement with the produced
artifacts instead of decreasing that engagement. Instead of using claude to
generate a wall of text tell your agent it needs to be boiled down to no more
than a paragraph of less than 10 sentences. One developer shepherding 10 agents
working on 5 different features is probably an anti-practice.

Encourage smaller units of work with a human in the loop and frequent checkins between
team members. Talking to an agent is not a substitute for talking to your tech lead.
