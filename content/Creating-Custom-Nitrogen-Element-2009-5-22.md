+++
title = "Creating Custom Nitrogen Elements"
date = 2009-05-22T19:05:57Z
in_search_index = true
[taxonomies]
tags = [
	"Site News",
	"ajax",
	"erlang",
	"event driven",
	"nitrogen",
	"tutorial",
	"functional",
	"web framework",
  "coding",
]
+++
<a href="http://github.com/rklophaus/nitrogen/tree/master">Nitrogen</a> is a web framework written in erlang for Fast AJAX Web applications. You can get <a href="http://github.com/rklophaus/nitrogen/tree/master">Nitrogen on github</a> Nitrogen comes with a set of useful controls, or elements in nitrogen parlance, but if you are going to do anything more fancy than a basic hello world you probably want to create some custom controls. This tutorial will walk you through the ins and outs of writing a custom element for Nitrogen. We will be creating a simple notification element similar to one I use in the Iterate! project. It will need to be able to: <ul> <li> show a message</li> <li>have a way to dismiss it</li> <li> and optionally expire and disappear after a configurable period of time</li> </ul> Every Nitrogen element has two main pieces = "the Record and the Module. I'll go through each in order and walk you through creating our notification element. <h2>The Record</h2> The record defines all the state required to create a nitrogen element. Every record needs a certain base set of fields. These fields can be added to your record with the ?ELEMENT_BASE macro. The macro is available in the nitrogen include file wf.inc. That include file also gives you access to all the included nitrogen element records. Below you can see the record definition for our notify element. Since it is very simple in it's design it only needs the base elements and two additional fields. expire to handle our optional expiration time and default to false to indicate no expiration. msg to hold the contents of our notification."

```erlang
%Put this line in an include file for your elements
-record(notify, {?ELEMENT_BASE(element_notify), expire=false, msg}).
```

```erlang
% put these at the top of your elements module
-include_lib("nitrogen/include/wf.inc").
% the above mentioned include file you may call it whatever you want
-include("elements.inc").
```

The ELEMENT_BASE macro gives your element several fields and identifies for the element which module handles the rendering of your nitrogen element. You can specify any module you want but the convention is to name the module with element_element_name. The fields provided are: id, class, style, actions, and show_if. You can use them as you wish when it comes time to render your element. Which brings us to the module. <h2>The Module</h2> Of the two pieces of a nitrogen element the module does the manual labor. It renders and in some cases defines the handlers for events fired by the element. The module must export a render/2 function. This function will be called whenever nitrogen needs to render a particular instance of your element. It's two arguments are = "The ControlId, and the Record defining this element instance. Of these the ControlID is probably the least understood. It is passed into your render method by nitrogen and is the assigned HTML Id for your particular element. This is important to understand because, when you call the next render method in your elements tree, you will have to pass an ID on. The rule of thumb I use is that if you want to use a different Id for your toplevel element then you can ignore the ControlId. Otherwise you should use it as the id for your toplevel element in the control. So your element's module should start out with something like this:"

```erlang
-module(element_notify).
-compile(export_all).
-include_lib("nitrogen/include/wf.inc").
-include("elements.hrl").
% give us a way to inspect the fields of this elements record
% useful in the shell where record_info isn't available
reflect() -&gt; record_info(fields, notify).
% Render the custom element
render(ControlId, R) -&gt;
    % get a temp id for our notify element instance
    Id = ControlId,
    % Our toplevel of the element will be a panel (div)
    Panel = #panel{id=Id},
    % the element_panel module is used to render the panel element
    element_panel:render(Id, Panel),
    % Or use the alternative method:
    Module = Panel#panel.module,
    Module:render(Id, Panel).
```

Notice that the records module attribute tells us what module we should call to render the element in the alternative method. In our case we will just hardcode the module since it's known to us. So now we have a basic element that renders a div with a temp id to our page. That's not terribly useful though. We actually need this element to render our msg, and with some events attached. Lets add the code to add our message to the panels contents.

```erlang
Panel = #panel{id=Id, body=R#notify.msg},
element_panel:render(ControlId, Panel)
```

Now whatever is in the msg attribute of our notify record will be in the body of the panel when it gets rendered. All we need is a way to dismiss it. A link should do the trick. But now we have a slight problem. In order to add our dismiss link we need to add it to the body of the Panel. but the msg is already occupying that space. We could use a list and prepend the link to the end of the list for the body but that doesn't really give us a lot of control over styling the element. what we really need is for the msg to be in an inner panel and the outer panel will hold any controls the element needs.

```erlang
Link = #link{text="dismiss"},
InnerPanel = #panel{body=R#notify.msg},
Panel = #panel{id=Id, body=[InnerPanel,Link]},
element_panel:render(ControlId, Panel)
```

Our link doesn't actually dismiss the notification yet though. To add that we need to add a click event to the link. Nitrogen has a large set of events and effects available. You can find them . We will be using the click event and the hide effect.

```erlang
Event = #event{type=click,
actions=#hide{effect=blind, target=Id}},
Link = #link{text="dismiss", actions=Event},
```

Now our module should look something like this:

```erlang
-module(element_notify).
-compile(export_all).
-include_lib("nitrogen/include/wf.inc").
-include("elements.hrl").
% give us a way to inspect the fields of this elements record
% useful in the shell where record_info isn't available
reflect() -&gt; record_info(fields, notify).
% Render the custom element
render(ControlId, R) -&gt;
    % get a temp id for our notify element instance
    Id = ControlId,
    % Our toplevel of the element will be a panel (div)
    Event = #event{type=click, actions=#hide{effect=blind, target=Id}},
    Link = #link{text="dismiss", actions=Event},
    InnerPanel = #panel{body=R#notify.msg},
    Panel = #panel{id=Id, body=[InnerPanel,Link]},
    % the element_panel module is used to render the panel element
    element_panel:render(Id, Panel).
```

This is a fully functional nitrogen element. But it's missing a crucial feature to really shine. Our third feature for this element was an optional expiration for the notification. Right now you have to click dismiss to get rid of the element on the page. But sometimes we might want the element to go away after a predetermined time. This is what our expire record field is meant to determine for us. There are three possible cases for this field. <ul> <li>set to false (the default)</li> <li>set to some integer (the number of seconds after which we want to go away)</li> <li>set to anything else (the error condition)</li> </ul> This is the kind of thing erlang's case statement was made for:


```erlang
case R#notify.expire of
  false -&gt;
    undefined;
  N when is_integer(N) -&gt;
    % we expire in this many seconds
    wf:wire(Id, #event{type='timer', delay=N, actions=#hide{effect=blind, target=Id}});
  _ -&gt;
    % log error and don't expire
    undefined
end
```

Notice the wf:wire statement. wf:wire is an alternate way to add events to a nitrogen element. Just specify the id and then the event record/javascript string you want to use. I've noticed that for events of type timer wf:wire works better than assigning them to the actions field of the event record. No idea why because I have not looked into it real closely yet. Now our module looks like this:

```erlang
-module(element_notify).
-compile(export_all).
-include_lib("nitrogen/include/wf.inc").
-include("elements.hrl").
% give us a way to inspect the fields of this elements record
% useful in the shell where record_info isn't available
reflect() -&gt;record_info(fields, notify).
% Render the custom element
render(_, R) -&gt;
  % get a temp id for our notify element instance
  Id = ControlId,
  % Our toplevel of the element will be a panel (div)
  case R#notify.expire of
    false -&gt;
      undefined;
    N when is_integer(N) -&gt;
      % we expire in this many seconds
      wf:wire(Id, #event{type='timer', delay=N, actions=#hide{effect=blind, target=Id}});
    _ -&gt;
      % log error and don't expire
      undefined
  end,
  Event = #event{type=click, actions=#hide{effect=blind, target=Id}},
  Link = #link{text="dismiss", actions=Event},
  InnerPanel = #panel{body=R#notify.msg},
  Panel = #panel{id=Id, body=[InnerPanel,Link]},
  % the element_panel module is used to render the panel element
  element_panel:render(ControlId, Panel).
```

We have now fulfilled all of our criteria for the element. It shows a message of our choosing. It can be dismissed with a click. And it has an optional expiration. One last thing to really polish it off though would to allow styling through the use of css classes. The ELEMENT_BASE macro we used in our record definition gives our element a class field. We can use that to set our Panel's class, allowing any user of the element to set the class as they wish like so:

```erlang
Panel = #panel{id=Id, class=["notify ", R#notify.class],
body=[InnerPanel,Link]},
```

This gives us the final module for our custom element:

```erlang
-module(element_notify).
-compile(export_all).
-include_lib("nitrogen/include/wf.inc").
-include("elements.hrl").
% give us a way to inspect the fields of this elements record
% useful in the shell where record_info isn't available
reflect() -&gt; record_info(fields, notify).
  % Render the custom element
  render(_, R) -&gt;
  % get a temp id for our notify element instance
  Id = ControlId,
  % Our toplevel of the element will be a panel (div)
  case R#notify.expire of
    false -&gt;
      undefined;
    N when is_integer(N) -&gt;
      % we expire in this many seconds
      wf:wire(Id, #event{type='timer', delay=N, actions=#hide{effect=blind, target=Id}});
    _ -&gt;
      % log error and don't expire
      undefined
  end,
  Event = #event{type=click, actions=#hide{effect=blind, target=Id}},
  Link = #link{text="dismiss", actions=Event},
  InnerPanel = #panel{body=R#notify.msg},
  Panel = #panel{id=Id, class=["notify ", R#notify.class],
  body=[InnerPanel,Link]},
  % the element_panel module is used to render the panel element
  element_panel:render(ControlId, Panel).
```

I will cover delegated events and more advanced topics in a later tutorial.
