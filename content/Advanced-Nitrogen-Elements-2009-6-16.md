+++
title = "Advanced Nitrogen Elements"
date = 2009-06-16T23:33:58
in_search_index = true
[taxonomies]
tags = [
    "Site-News",
    "erlang",
    "javascript",
    "nitrogen",
    "tutorial",
    "web-framework",
]
+++
In my <a href="http://jeremy.marzhillstudios.com/index.php/site-news/creating-custom-nitrogen-elements/">last post</a> I walked you through creating a basic nitrogen element. In this one I'll be covering some of the more advanced topics in nitrogen elements. <ul> <li>Event handlers and delegation</li> <li>scripts and dynamic javascript postbacks</li> </ul> <h3>Nitrogen Event handlers</h3> Nitrogen event handlers get called for any nitrogen event. A nitrogen event is specified by assigning #event to an actions attribute of a nitrogen element. The event handler in the pages module will get called with the postback of the event. Postbacks are an attribute of the event record and define the event that was fired. To handle the event you create an event function in the target module that matches your postback. For Example:
<code syntax="erlang">
% given this event
#event{ type=click, postback={click, Id} }
% this event function would handle it
event({click, ClickedId}) -&gt;
io:format(&quot;I [~p] was clicked&quot;, [ClickedId]) .
</code>
Erlangs pattern matching makes it especially well suited for this kind of event based programming. The one annoying limitation of this event though is that each page has to handle it individually. You could of course create a dispatching module that handled the event for you but why when nitrogen already did it for you. You can delegate an event to a specific module by setting the delegate attribute to the atom identifying that module.
<code syntax="erlang">
% delgated event
#event{ type=click, postback={click, Id}, delegate=my_module }
</code>
You can delgate to any module you want. I use the general rule of thumb that if the event affects other elements on the page then the page module should probably handle it. If, however, the event doesn't affect other elements on the page then the element's module can handle it. <h3>Scripts and Dynamic Postback</h3> Now lets get make it a little more interesting. Imagine a scenario where we want to interact with some javascript on a page and dynamically generate data to send back to nitrogen. As an example lets create a silly element that grabs the mouse coordinates of a click on the element and sends that back to nitrogen. A first attempt might look something like so:
<code syntax="erlang">
-record(silly, {?ELEMENT_BASE(element_silly)}). </code>
And the module is likewise simple:
<code syntax="erlang">
-module(element_silly).
-compile(export_all).
-include(&quot;elements.hrl&quot;).
-include_lib(&quot;nitrogen/include/wf.inc&quot;).
render(ControlId, R) -&gt;
    Id = wf:temp_id(),
    %% wait!! where do we get the loc from?!
    ClickEvent = #event{type=click, postback={click, Loc}}
    Panel = #panel{id=Id, style=&quot;width:'100px' height='100px'&quot;,
               actions=ClickEvent}, element_panel:render(Panel).

event({click, Loc}) -&gt;
    wf:update(body, wf:f(&quot;you clicked at point = "~s&quot;, Loc))."
</code>
Well of course you spot the problem here. Since the click happens client side we don't know what to put in the Loc variable for the postback. A typical postback won't work because the data will be generated in the client and not the Nitrogen server. So how could we get the value of the coordinates sent back? The javascript to grab the coordinates with jquery looks like this = "<code syntax="javascript">"
var coord = obj('me').pageX + obj('me').pageY;
</code> To plug that in to the click event is pretty easy since action fields in an event can hold other events or javascript or a list combining both:
<code syntax="erlang">
Script = &quot;var coord = obj('me').pageX + obj('me').pageY;&quot;,
ClickEvent = #event{type=click, postback={click, Loc}, actions=Script}
</code>
Now we've managed to capture the coordinates of the mouse click, but we still haven't sent it back to the server. This javascript needs a little help. What we need is a drop box. Lets enhance our element with a few helpers:
<code syntax="erlang">
-module(element_silly).
-compile(export_all).
-include(&quot;elements.hrl&quot;).
-include_lib(&quot;nitrogen/include/wf.inc&quot;).
render(ControlId, R) -&gt;
    Id = wf:temp_id(),
    DropBoxId = wf:temp_id(),
    MsgId = wf:temp_id(),
    Script = wf:f(&quot;var coord = obj('me').pageX + obj('me').pageY; $('~s').value = coord;&quot;,
    [DropBoxId]),
    ClickEvent = #event{type=click, postback={click, Id, MsgId},
                        actions=Script},
    Panel = #panel{id=Id, style=&quot;width:'100px'; height='100px'&quot;,
                   actions=ClickEvent, body=[#hidden{id=DropBoxId},
                                             #panel{id=MsgId}]},
    element_panel:render(Panel).

event({click, Id, Msg}) -&gt;
    Loc = hd(wf:q(Id)),
    wf:update(Msg, wf:f(&quot;you clicked at point = "~s&quot;, Loc))."
</code>
Ahhh there we go. Now our element when clicked will: <ol> <li>use javascript to grab the coordinates of the mouse click</li> <li>use javascript to store those coordinates in the hidden element</li> <li>use a postback to send the click event back to a nitrogen event handler with the id of the hidden element where it stored the coordinates.</li> </ol> We have managed to grab dynamically generated data from the client side and drop it somehwere that nitrogen can retrieve it. In the process we have used an event handler, custom javascript, and dynamic javascript postbacks. <strong>Edit</strong> = "Corrected typo - June 16, 2009 at 11:40 pm "
