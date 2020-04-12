+++
title = "go-html-transform an html transformation and scraping library"
date = 2013-02-26T17:05:00Z
in_search_index = true
[taxonomies]
tags = [
  "projects",
	"go",
	"html",
	"css",
]
+++

http://code.google.com/p/go-html-transform is my html transformation library for go. I use it as an html templating language and scraping library. It's not your typical approach to html templating but it's an approach I've really come to enjoy. HTML templating can be grouped in roughly about 3 categories.

1. Templating languages.
1. HTML DSLs.
1. Functional transforms.

go-html-transform is an example of that last one. The basic theory is that an html template is just data. No logic is in the template. All the logic is in the functions that operate on the template and any input data. Using the input data you can transfrom a template and then render the transformed AST back into html. This has a number of benefits.

* Your template transforms are context aware.
* Multipass templating is just another transform.
* All your logic is expressed in real honest to goodness code not a limited templating language. In the case of go-html-transform your templating logic is actually typechecked by the go compiler.
* It's impossible to generate bad html.
* Your mocks are your templates.
* You can use an html dsl in combination with this approach as well if the dsl outputs the same AST.

Example usage.
=======

``` go
package main

import (
  "strings"
  "os"

  "code.google.com/p/go-html-transform/html/transform"
  "code.google.com/p/go-html-transform/h5"
)

func toSSL(url string) string {
  return strings.Replace("http:", "https:", 1)
}

func main() {
  f, err := os.Open("~/file.html")
  defer f.Close()
  if err != nil { return } // handle errors here.
  tree, err := transform.NewDocFromReader(f)
  if err != nil { return } // handle errors here.
  t := transform.NewTransformer(tree)
  t.ApplyAll(
    Trans(ReplaceChildren(h5.Text("foo"), "span"), // replace every span tags contents with foo
    // turn every link and img into an ssl link
    Trans(TransformAttrib("href", toSSL), "a"),
    Trans(TransformAttrib("src", toSSL), "img"),
  )

  t.Render(os.Stdout) // render html to stdout.
}
```
