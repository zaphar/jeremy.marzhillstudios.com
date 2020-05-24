+++
title = "First Look at Polymer Elements"
author = "Jeremy Wall"
date = 2013-09-17
in_search_index = true
[taxonomies]
tags = [
	"site-news",
	"polymer",
	"web",
	"w3c",
	"webcomponents",
]
+++
Introduction
============

For work I've been getting up to speed on the W3C's set of webcomponents standards. Which means I've been looking at [Polymer](http://polymer-project.org). Polymer is both an experimental javascript framework and a shim library that simulates the portions of the W3C standard which are not yet implemented in browsers. Specifically I've been looking at [Custom Elements](https://html.spec.whatwg.org/multipage/custom-elements.html) and [Templates](https://html.spec.whatwg.org/multipage/scripting.html#the-template-element) since they are the more concrete portions of the standard right now.

At some point when you are exploring a new technology the docs and tutorials stop being useful to you and to really get a feel you have to build something in it. I decided to port parts of a javascript application, [DynamicBible](http://dynamicbible.com), that I had already written as a learning exercise. [DynamicBible](http://dynamicbible.com) currently uses [requirejs](http://requirejs.org) for it's javascript code as a way to manage dependencies and keep scoping sane. This made it perfect for my purposes since it allowed me to explore two types of polymer elements.

* UI elements.
* Utility elements that don't have a visible presence on the page.

For my purposes I ported the DynamicBible search box and a requirejs importer element. In this article I'll cover the search box element. The requirejs element will be covered a later article.

Creating your own Polymer Element
=================================

```html
<polymer-element name="my-element">
<template>
...
</template>
<script>
...
</script>
</polymer-element>
```

The `<polymer-element>` is the declarative way to define your polymer element in html itself. The bare minimum to define a polymer element would be

```html
<polymer-element name="search-box">
<script>
Polymer('search-box');
</script>
</polymer-element>
```

This is as about as useful as the span element though and html already has a span element. We need a little more than this to be worth it. Our element needs some attributes and behavior. Polymer lets us describe the expected attributes using an attribute called, what else, `attributes`.

```html
<polymer-element name="search-box" attributes="id query">
```

As for the behavior to attach to this element, that brings us the the Polymer construction function.

```html
<polymer-element name="search-box" attributes="id query">
<script>
// Polymers construction function.
Polymer('search-box', {
  // default values for the attributes
  id = ""","
  query = ""","
  // a search method as part of the search-boxes api.
  search = "function() {"
    submitSearch(this.value);
  }
});
</script>
</polymer-element>
```

You can use the element the same way you would any other html element.

```html
<search-box id="searchBox"></search-box>
```

Now our element has a method on it that will submit a search using the value of our search-box query attribute. We could trigger this behavior right now with javascript.

```js
document.querySelector('#searchBox').query = "what is a polymer element?";
document.querySelector('#searchBox').search();
```

It's kind of silly that we have to do that manually with javascript though. What we really want is for this element to detect changes in our query and perform the search for us.

```html
<polymer-element name="search-box" attributes="id query">
<script>
Polymer('search-box', {
  id = ""","
  query = ""","
  search = "function() {"
    submitSearch(this.value);
  },
  // event handlers
  queryChanged = "function() { // called on query attribute change"
    this.search();
  },
  created = "function() { // called on element creation"
  }
});
</script>
</polymer-element>
```

Now when the element's query attribute changes a search is triggered.

Up to now our element hasn't been very visible. We need to give it an image boost. We can do this two different ways.

1. Using a template
2. Using element inheritance

We'll go with the template element for now. The element inheritance will come in handy later.

```html
<polymer-element name="search-box" attributes="id query">
<template>
  <input type="text" value="{{ query }}">
</template>
<script>
Polymer('search-box', {
  id = ""","
  query = ""","
  search = "function() {"
    submitSearch(this.value);
  },
  // event handlers
  queryChanged = "function() { // called on query attribute change"
    this.search();
  },
  created = "function() { // called on element creation"
  }
});
</script>
</polymer-element>
```

There are a number of things going on in this template element. First we define some html that will be used whenever we render the element on a page.  There is some complicated merging logic involving the [shadow dom](https://dom.spec.whatwg.org/#shadowroot) but we'll ignore that for now.  Second our value attribute on the the input element has funny looking content.  The `{{ query }}` tells polymer that the contents of the text box and the query a should be kept in sync. A change to one of them is reflected in the other. Furthermore a change to the input box will result in the queryChanged event firing and causing a search to get submitted. There are several more built in events and Polymer includes a way to create and listen to your own events. as well.

I'll cover a utility element that shims requirejs modules to make them useable in your polymer elements in a later article.

Out elements template element isn't terribly complicated and it turns out in our case is completely unnecessary. We can use `extends` to tell Polymer our element should inherit from the input element.

Our last tweak to the search-box element looks like this.

```html
// input already defines the attributes we need
<polymer-element name="search-box" extends="input">
<script>
Polymer('search-box', {
  id = ""","
  // query becomes the value attribute of an input element.
  value = ""","
  search = "function() {"
    submitSearch(this.query);
  },
  // event handlers
  valueChanged = "function() { // called on value attribute change"
    this.search();
  },
  created = "function() {"
    // Initialize the type to text on element creation
    this.type = "text"
  }
});
</script>
</polymer-element>
```