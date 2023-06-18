+++
title = "Thoughts on Engineering Management after 7 years"
date = "2023-06-11"
in_search_index = true
[taxonomies]
tags = [
	"management",
	"software-engineering",
	"notes",
	"lists",
]
+++

I've just recently begun a new job. For 7 years I've been doing some form or or
another of engineering management at GoHealth, Inc. There were definitely
things that I appreciated about being a manager. Mentoring other engineers has
been one of the more rewarding things I've ever done in my career. But being a
manager is exhausting work. It's emotionally and mentally exhausting. I'm ready
to take a break from it all for at least a bit. I don 't know for sure that
I'll never do it again but I do know that I need to not be doing it for a while
so I can rest.

I do want to take some time to write down what I've learned being a manager as
I leave it behind. Some of what I learned is just general management learnings.
But some of it is more germaine to being an engineering leader specifically.
The following is a list of my collected notes over 7 years of being a manager
of software engineering teams. I've broken them up into General management
lessons and Engineering management lessons.

## General

* Peer review is an important signal in employee reviews.
  * An employee's peers have more on the ground knowledge of how someone
    is doing on the team.
  * As a manager we have context on how their contributions contribute to
    the company's goals.
* It is easier to break culture than it is to fix culture.
* Your decisions as a manager have a wide blast radius.
  * You need to have a light touch.
* Collaborative Working sessions are a useful forcing function.
  * But asynchronous effort is often more efficient.
* Matrix organizations have a higher communication burden. Lines of
  communication are mutating and fuzzy.
* Part of managing up is not hiding problems.
  * Sometimes you have to let things fail to ensure that problems get
    addressed.
* Part of managing down is owning and apologizing for mistakes.
  * Good employees will forgive and respect you for owning your mistakes.
  * Bad employees will be impossible to please. You will have to manage them
    out.

## Engineering

* Documentation is just as important as Code. Make sure you prioritize it.
  * Doctests help to ensure code documentation is up to date.
  * documentation that is versioned with the code is better than a wiki
  * generating and publishing docs from a repo as part of a ci/cd pipeline is
    preferred.
* Automated Testing is better than Manual every time.
* Scrum/Agile or other methodologies are a defensive workaround not a solution.
  * if you can fix the core problem then you won't need the methodology.
  * Process can't fix the problem of too much process.
* CI/CD get's progressively harder to implement the more software you have
  written.
  * You are better off starting out with it in place or very early on.
* All else being equal having a smaller set of supported technologies is an
  organizational super power.
  * It's important to choose a set that actually fits your needs.
* Zero Trust is hard if you didn't design for it in the beginning.
* During an outage it's not uncommon for people to be experiencing multiple
  different problems.
  * Make sure your team is categorizing each type of issue so you can
    distinguish between them.
  * Look for the systemic problem not the individual surface problems.
* If you have hired and run planning in a particular way for a long time then
  any dramatic change needs to be planned and communicated well ahead of time.
  * Make sure to include timelines and milestone in your communication.
  * Be aware that you are probably violating some sort of social contract with
    your people when you do so.
  * Expect emotions and departures in some cases.
