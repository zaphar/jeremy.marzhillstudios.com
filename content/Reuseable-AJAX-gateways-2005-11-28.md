+++
title = "Reuseable AJAX gateways"
date = 2005-11-28T16:13:20Z
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"APIs",
	"javascript",
	"Software-Development",
	"XML",
]
+++
Everyone knows about AJAX these days. You just about can't go anywhere on the net whithout hearing about it. And if you're a coder who want's to know more than just what library you should download to start using it you've probably done a little googling and came up with this site: <a href="http://developer.apple.com/internet/webcontent/xmlhttpreq.html">XMLHttpRequest Objects [developer.apple.com]</a> You even played around with the examples and made a few demo apps then realized. Hey!! How can I make these things reusable without ugly global variables and functions that check to see if the response came back yet? In short: how do I use this in a real app? Apple has done a really good job of showing how the xmlhttprequest object works. They even do a good job of showing some useful ways to use it. But if you're like me you want to go a bit farther. I like reusability. I also don't like using Global variables as a gatekeeper. So lets take a look at how we can make this code a little more reusable. The first thing to do is come up with a way to use multiple different functions as the handler for that onreadystate property. Using the same handler really cramps our style. Additionally having to write all that code to test our object's state is a real drag. It would be nice if we could avoid having to write that for every single function we use as a handler. Here is the solution: Let's start with this function here = "<code syntax=js>"
function loadXMLDoc(url) {
  req = false;
  // branch for native XMLHttpRequest object
  if(window.XMLHttpRequest) {
    try {
      req = new XMLHttpRequest();
    } catch(e) {
      req = false;
    }
    // branch for IE/Windows ActiveX version
  } else if(window.ActiveXObject) {
    try {
      req = new ActiveXObject("Msxml2.XMLHTTP");
    } catch(e) {
      try {
        req = new ActiveXObject("Microsoft.XMLHTTP");
      } catch(e) {
        req = false;
      }
    }
  }
  if(req) {
    req.onreadystatechange = processReqChange;
    req.open("GET", url, true);
    req.send("");
  }
}
</code> Now for this to do what we really need it to we need a couple of different things. That processReqChange function needs to be able to change dynamically. So lets add another function argument that will hold a function passed in to be used here. Like so = "<code syntax=js>loadXMLDoc(url, func)</code> then you can change<code syntax=js> req.onreadystatechange = processReqChange;</code> to <code syntax=js>req.onreadystatechange = func;</code> This will allow us to pass any function we want as the state change handler. Don't go deleting that processReqChange function yet though. We still need it. In fact lets take a look at that one right now shall we? <code syntax=js>"
function processReqChange() {
  // only if req shows "loaded"
  if (req.readyState == 4) {
    // only if "OK"
    if (req.status == 200) {
      // ...processing statements go here...
    } else {
      alert("There was a problem retrieving the XML data:\n" + req.statusText);
    }
  }
}
</code> We need this to keep checking our state and tell us when our response came back. We also need it to use any xmlhttprequest object we want it to. What we don't need it to do is retrieve our response for us. In short we need it to recieve a request object in it's arguments and return a response saying it's ok to process our response. So lets modify it a little shall we? <code syntax=js>
function processReqChange(req) {
  // only if req shows "loaded"
  if (req.readyState == 4) {
    // only if "OK"
    if (req.status == 200) {
      return 1;
      // it's safe now go ahead
    } else {
      alert("There was a problem retrieving the XML data:\n" + req.statusText);
    }
  }
  return 0;
  //it's not safe yet
}
</code> now when we pass this function a request object it returns 1 when we have our response and 0 when the response is not ready yet. Both of these functions are now reusable. But how exactly do we start using them? I thought you would never ask. lets build an example = "<code syntax=js>"
function append_to_id(el, contents) {
  var element = document.getElementById(el);
  //alert('appending = "' + contents.nodeValue );"
  element.appendChild(contents);
}
function append(url, el) {
  //alert('starting append operation');
  var func = function() {
    if (processReqChange(req)) {
      var ajax_return = req.responseXML;
      while (ajax_return.hasChildNodes()) {
        append_to_id(el, ajax_return.firstChild);
        ajax_return.removeChild(ajax_return.firstChild);
      }
    }
  }
  var req= loadXMLDoc(url, func);
}
</code> In the append function we create a dynamic function that we can pass to our loadXMLDoc function. That dynamic function contains the meat of what we are wanting to do. It uses an if statement that checks our processReqChange function for a valid return. When it gets a valid return the if statement processes our request. It couldn't be any eaiser. you can see full example code here = "<a href="http://jeremy.marzhillstudios.com/test/dev/ajax/js/ajax.js">Example Script</a>"
