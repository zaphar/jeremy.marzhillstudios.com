+++
title = "Using Reusable AJAX Gateways"
date = 2005-12-02T15:43:31Z
in_search_index = true

[taxonomies]
tags = [ 
	"APIs",
	"javascript",
	"Languages",
	"Software-Development",
	"User-Interface",
	"XML",
]
+++
So now I have a reusable ajax gateway. Just what exactly am I supposed to do with it? If you look around for a while you will start to notice everyone describing how you can use XSLT, SOAP, and all these other things to pass Objects back and forth. And again they all have suggestions for libraries you can use to do this in. But what if your not quite that ambitious? What if you wanted the speed and power and downright fun of using AJAX without all the huge libraries? Well as usuall I have an idea. You see what I really want to do with this is to retrieve pieces of html pages from the server to put into my current page. Simple enough right? Why I could just use cloneNode from the DOM api to do that. In fact if you looked at my example code from before you saw that I did exactly that. There's just one problem though. The cloned elements and test show up on your page alright but they aren't part of you html document. In fact the element don't obey any of your html rendering engines rules. It's as if you just went about making up fake tags to put in there. They don't do anything. What we need is a way to take our xml document and duplicate it's structure in our html document. <code syntax=js>duplicate_nodes();</code> to the rescue!!! I wrote a small function that takes our html fragments <em>(as I call them)</em> and duplicates them in our pages document. Here is how I did it = ""

<code syntax=js> function duplicate_nodes(node) { // get our node type name and list of children
  // loop through all the nodes and recreate them in our document
  //alert('calling duplicate_nodes: ' + node.nodeName + ' type = "' + node.nodeType);"
  var newnode;
  if (node.nodeType == 1) {
    //alert('element mode');
    newnode = document.createElement(node.nodeName);
    //alert('node added');
    newnode.nodeValue = node.nodeValue
    //test for attributes
    var attr = node.attributes;
    var n_attr = attr.length
    for (i = 0; i < n_attr; i++) {
      newnode.setAttribute(attr.item(i).name, attr.item(i).nodeValue);
      alert('added attribute: ' + attr.item(i).name + ' with a value of = "' + attr.item(i).nodeValue);"
    }
  } else if (node.nodeType == 3 || node.nodeType == 4) {
  //alert('text mode');
  try {
    newnode = document.createTextNode(node.data);
    //alert('node added');
  } catch(e) {
    alert('failed adding node');
  }
} while (node.firstChild) {
  if (newnode) {
    //alert('node has children');
      var childNode = duplicate_nodes(node.firstChild);
      //alert ('back from recursive call with:' + childNode.nodeName);
      newnode.appendChild(childNode);
      node.removeChild(node.firstChild);
    }
  }
  return newnode;
} </code> Now this functions currently only handles elements, their attributes, and text or cdata nodes. entity and other node type support can be added easily however. Also I still need to do some testing on the attribute handling to see if it correctly handles stuff like eventhandlers and id attributes but it works. <em>(<strong>Edit</strong>: It handles event handlers with no modification on firefox)</em> Lets do like all good code hackers do and take it apart :-) Our first task in this function is to see what kind of node we are handling. This is contained the in the nodeType property of the node object. When this is a 1 it's an element. When it's a 3 or 4 it's CDATA or a Text node. Thus our if statements: </code><code syntax=js> if (node.nodeType == 1) { } else if (node.nodeType == 3 || node.nodeType == 4) { } </code> Elements and Text or CDATA have to be handled very differently so we check for these two types before doing anything else. In the case of an element node <em>(type 1)</em> we need two more peices of information: <code syntax=js>node.nodeName</code> and <code syntax=javasript>node.nodeValue</code> These provide us with the details we need when recreating our element in the html document. They are pretty well self explanatory one is the name or tagName of the element and the other is the elements value. Now we are ready to start creating our new element in the current document like so = "<code syntax=js> newnode = document.createElement(node.nodeName);"
//alert('node added');
newnode.nodeValue = node.nodeValue
</code> Now how do we handle it's attributes? A simple for loop will do that for us. the attributes property gives us a list of the nodes attributes. The calling the length property for that list gives us how many attributes there are. And the for loop loops through each one duplicating it in our newnode like so = "<code syntax=js> //test for attributes var attr = node.attributes;"
var n_attr = attr.length
for (i = 0; i < n_attr; i++) {
  newnode.setAttribute(attr.item(i).name, attr.item(i).nodeValue);
  alert('added attribute: ' + attr.item(i).name + ' with a value of = "' + attr.item(i).nodeValue);"
}
</code> And that's all we need to recreate our element and its attributes. Text nodes are even easier to handle. you just need one piece of information for them. The data property. create a new text node using the document.createTextNode method with the node.data property and your good to go = "</code><code syntax=js> //alert('text mode');"
try {
  newnode = document.createTextNode(node.data);
  //alert('node added');
} catch(e) {
  alert('failed adding node');
}
</code> There is just one last thing to take care of though. What if our node has children? What do you do then? Function Recursion to the rescue!! The firstChild property of a node will tell us if there are any children and a while loop will keep looping as long as it returns true. All we have to do is: <ul> <li> call duplicate_nodes recursively with that child as an argument</li> <li> append the returned node to the newnode</li> <li>remove each child from the node</li> <li>and keep looping till no more children exist</li> </ul> Here is the while loop = "<code syntax=js> while (node.firstChild){"
  if (newnode) {
    //alert('node has children');
    var childNode = duplicate_nodes(node.firstChild);
    //alert ('back from recursive call with:' + childNode.nodeName);
    newnode.appendChild(childNode);
    node.removeChild(node.firstChild);
  }
}
</code> The last task of our function is to return the duplicated node <code syntax=js>return newnode;</code> our duplicate function does not append the node anywhere in our document so it won't show up. That is the job of the calling function. It can append the new node where ever it wants.
