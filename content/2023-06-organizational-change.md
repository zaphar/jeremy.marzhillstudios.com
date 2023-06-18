+++
title = "Organizational Change"
date = "2023-06-16"
in_search_index = true
[taxonomies]
tags = [
	"software-engineering",
    "sre",
    "devops",
    "sys-admin",
    "culture",
    "organization",
]
+++

Our industry, like any other, is prone to fads and trend following. Sometimes
the fad is positive, sometimes it's neurtal, and sometimes it's misguided.
Adopting a fad just to follow the crowd is almost always a mistake though. The
fad around having DevOps, SREs, instead of SysAdmins is an example where many
companies are adopting a trend as a way of following the crowd. Companies of a
certain type of engineering culture get a lot of value out of having SREs
and/or DevOps. But just as many companies fail to properly implement those
roles or teams. It doesn't help that the job descriptions often get muddled and
end up with overlap across companies.

This trend can often get traction at a company because of real problems they
might be trying to fix. Those problems could be something like the following:

* Unreliable software in production.
* Slow delivery of software changes to production.
* Long time to remediation during outages.

These are real problems that companies have and DevOps or SRE teams are often
seen as a way to fix those problems somehow. If the company isn't careful
though they can adopt the team as a cargo cult going through the motions out of
faith rather than an actual understandng of the sources of the problems they
are trying to solve. As a result those teams and initiatives are set up for
failure. The problems are important to solve though so if your company or
engineering organization is experiencing those problems there are some
strategies you can use to attack them.

## Articulate the problem clearly

If the problem is unreliable software in production, then make sure you
articulate that clearly. This doesn't mean just stating the problem but also
how you are measuring it in some way. What are the indicators of unreliability
in production? How do you count instances of unreliability? How far do you want
to move that count of instances in the future?

If the problem is slow delivery, then how slow is that delivery? What is your
mean time from start to merge? What is your mean time from merge to production
release? What is your target time for those phases?

If the problem is long time to remediation during outages, then how long is
that time to remediation? What is the mean time to remediation? How long are
your outliers? What is your target mean time for remediation?

It's important to note that picking the wrong target metric can cause strange
outcomes. Measuring the problem is important to understand it but if you
misstate the problem and target improvement metric then you may not get the
result you actually wanted. Think about this carefully and consider how the
team might interpret or even game this metric.

## Do a root cause analysis of the problem

Root cause analysis helps you get to root of the cause of the problem in your
organization. Every organization is different. Their structure is different.
Their culture is different. Their processes are different. Cargo culting a
process or methodology without understanding why they work and how they would
fit in your own organization will doom you to failure. Give a thorough analysis
of why you are currently experiencing this problem. What parts of your
organizations structure, culture, and process contributes to the problems.

This step is critical because it will inform you as to whether adopting a new
methodology or set of ideas in the zeitgeist will actually address your
problem. It's important to be honest in this step and own the failures in your
organizational setup. If you aren't honest about the ways your organizational
setup is failing you will not be addressing the real problems.

## Prepare to adopt the solution

The solution to these problems is going to involve changes in at least one but
probably 2 or more of the your teams structure, process, and culture. These
kind of changes typically are highly disruptive and also can take a while to
fully implement and take root. They also involve a fair amount of emotions to
those impacted and your leaders will have to deal with the fallout of those
impacts.

### Structure

Structural changes appear to be an easy change to make. Create and staff a new
team with a clear charter and measure of success. Just creating a new team
is only the beginning. You need to empower that team to actually make progress
toward success. You will need to be able to articulate their value to the
organization in a way that the rest of the organization can understand. They
will need processes that support them. They will need authority to make
decisions and access to whatever resources they need to make the changes in the
organization that they need to make. One of the secrets of success for SREs at
Google was that SRE's had complete autonomy to say no to any team who didn't
meet their bar for support. They were also incredibly valuable since having
SREs meant that you didn't have to carry a pager as a developer or be involved
in stressful outages for the most part. The value proposition to developer
teams combined with the authority the SRE teams had meant that teams were
highly motivated to meet that bar. It was badge of honor to meet the SRE bar
and qualify for an SRE team. It was a mark of shame if you lost your SRE team
and losing it was entirely under the scope of that SRE teams authority.

### Process

Process changes may be warranted. Planning for them can fall into a few
different traps though. Processes need to occupy a happy middle ground between
too ridgid and restrictive or not clear and specific enough. Ideally processes
have a clear and understandable path from A to B. This may require you to have
escape hatches and often means that processes need to be lightweight and well
documented in order to be successful. You should expect that you will miss
cases so be sure to include a way to propose modification or augmentations.
You'll need to balance the tendency for processes to grow without bound by
providing a way to trim it. Process improvement is harder than it sounds.

Process also takes some time to become second nature for people. The more
complex the process the longer it takes to sink in. Be sure to be realistic and
pragmatic about the impact of your changes so people aren't frustrated. It may
in the short term increase times for tasks even if the intent is to shorten
those times.

### Culture

Note that cultural problems are notoriously hard to fix. Culture flows from the
top down so you may need to have some hard conversations with leaders in the
organization. Culture is also very sticky once it has taken hold. Consistency
and frequent involvement by leaders in changing the cultural principles is
going to be key. Hypocrisy on the part of your leaders will doom the whole
enterprise to fail.

If your leaders aren't fully bought in on the cultural change then will not be
successful. You either need to reconsider the change or in the worst case
replace your leaders. If you aren't prepared or unable to do that for some
reason then the cultural change is a bad fit for your company and you will need
pick a different path.

## Conclusion

There is no one size fits all solution for engineering organizational problems
because there every organiation is different in structure, processes, and
culture. New teams or new organizational paradigms are modifications of the
organization and as such need to take into account all the ways that
organization is unique. One company having success with it doesn't imply that
you will. You can learn from their experience by understanding what about their
own organization and how they changed it led to success. But pretending like
you can be exactly like them will only end in failure. Find your own path that
matches where you as an organization are and identify the things you *really*
need to change. Find a way to change those things that will work with your team
and your organizations idiosyncrosies. Don't be a cargo cult. Be an expert in
your organization and it's challenges.
