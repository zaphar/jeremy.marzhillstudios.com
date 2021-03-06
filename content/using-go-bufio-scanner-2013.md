+++
title = "Using bufio.Scanner to build a Tokenizer"
date = 2013-05-09T00:00:00Z
in_search_index = true
[taxonomies]
tags = [
	"Site-News",
	"tutorial",
	"go",
	"golang",
	"io",
	"composition",
	"parsing",
	"tokenizing",
]
+++
<p>Go's standard lib comes with a number of useful tools. Each one of them written in an idiomatic fashion illustrating how to design good api's in Go. One of the most informative and useful are the io packages. both the "io" and "bufio" packages are examples of beautiful and idiomatic Go. I've recently decided to look at using the bufio.Scanner to build a tokenizer for a very simple lisp. The tokenizer's job is to emit a stream of tokens for each element of the lisp's syntax. The syntax is very basic with only the following tokens.

<ul>
<li> Whitespace a series of newline, linefeed, tab or space characters
<li> StartExpr = "a single '('"
<li> EndExpr = "a single ')'"
<li> String = "anything between double or single quotes with \ escaping the next character."
<li> Number = "any series of numbers surrounded by whitespace"
<li> Word = "any series of characters surrounded by whitespace and starting with a-z or A-Z"
</ul>

<p>The tokenizer we are going to build should emit a stream of these tokens for us while also keeping track of where in the file these tokens occur. <a href='http://golang.org/pkg/bufio'>Go's bufio package</a> has a useful general purpose Scanner type that splits an io.Reader into a series of byte slices for you. Our first task is to figure out how to use the Scanner to split up any reader into a stream of slices representing each of these tokens. The Scanner type has 5 methods. We'll be focusing on just 4 of them.

<ul>
<li> The Scan method scans the stream looking for the next byte slice to emit. It returns false if the Scan hit an error or EOF.
<li> The Bytes method returns the current byte slice after Scan has run.
<li> The Err method returns the last non io.EOF error encountered by Scan.
<li> The Split method sets the SplitFunc to use for the next Scan.
</ul>

<p>Together these give us all the tools necessary to tokenize any io.Reader. The first step is to create a Scanner to use.

<code syntax="go">
package main

import (
       "strings"
       "bufio"
       "fmt"
)

func main() {
     s := bufio.NewScanner(strings.NewReader("(foo 1 'bar')\n(baz 2 'quux')"))
     for s.Scan() {
         tok := s.Bytes()
         fmt.Println("Found token ", tok)
     }
}
</code>
<p><a href="http://play.golang.org/p/fhOV_4fVOI">You can play with this code here http://play.golang.org/p/fhOV_4fVOI</a>. Out of the box the scanner splits the io.Reader into lines which is obviously not what we want. In order to let us specify our own rules for splitting bufio.Scanner uses composition. We can pass in our splitting logic in the form of a <a href="http://golang.org/pkg/bufio/#Scanner">SplitFunc</a>. A SplitFunc takes a candidate slice of data for splitting and returns how far to advance the position in the reader stream, the byte slice to return for this split, and an error if any is needed. Below you'll find the basic skeleton for our splitting logic.

<code syntax="go">
package main

import (
       "strings"
       "bufio"
       "fmt"
)

func consumeWord(data []byte) (int, []byte, error) {
	// TODO
	return 0, nil, nil
}

func consumeWhitespace(data []byte) (int, []byte, error) {
	// TODO
	return 0, nil, nil
}

func consumeNum(data []byte) (int, []byte, error) {
	// TODO
	return 0, nil, nil
}

func consumeString(data []byte) (int, []byte, error) {
	// TODO
	return 0, nil, nil
}

func main() {
     s := bufio.NewScanner(strings.NewReader("(foo 1 'bar')\n(baz 2 'quux')"))
     split := func(data []byte, atEOF bool) (advance int, token []byte, err error) {
		// Because our grammar is simple we can switch off the first
		// character in the reader.
		switch data[0] {
		case '(', ')':
			advance, token, err = 1, data[:1], nil
		case '"', '\'':
			advance, token, err = consumeString(data)
		case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
			advance, token, err = consumeNum(data)
		case ' ', '\n', '\r', '\t':
			advance, token, err = consumeWhitespace(data)
		default:
			advance, token, err = consumeWord(data)
		}
		return
	}
	s.Split(split)
     for s.Scan() {
         tok := s.Bytes()
         fmt.Println("Found token ", tok)
     }
}
</code>

<p>The split func inspects the start of our candidate slice and determines how it should handle it. The parens case is easy so we implented it first by telling the Scanner to advance by one byte and emit a byte slice of size one containing the paren and nil for the error. We've defined names for consume functions for each of our other tokens but left them unimplemented so far. We'll start with consumeWord to give an example of how they should work.

<code syntax="go">
func consumeWord(data []byte) (int, []byte, error) {
	var accum []byte
	for i, b := range data {
		if b == ' ' || b == '\n' || b == '\t' || b == '\r' {
			return i, accum, nil
		} else {
			accum = append(accum, b)
		}
	}
	return 0, nil, nil
}
</code>

<p>Tokenizing a Word token is easy. A Word starts with any character that isn't a quote, paren or Number and they continue until you hit whitespace. Our switch statement handles the quote, paren, and number cases specially and anything left over is a Word. Then we call consumeWord with the candidate slice. consumeWords job is to scan the candidate for whitespace accumulating as we go. We could if we want bypass the accumulator but this was easier to understand for now. If no whitespace is seen then we don't have a full word yet so return 0, nil, nil. If we do encounter any whitespace then return the amount to advance, not including the whitespace, as well the word we've accumulated and nil. The scanner will keep trying our split function on increasing slice sizes until it either gets an error, non-zero advance or hits the end of the stream. We code similar consume functions for the Whitespace, String, and Number tokens.

<code syntax="go">
func consumeWhitespace(data []byte) (int, []byte, error) {
	var accum []byte
	for i, b := range data {
		if b == ' ' || b == '\n' || b == '\t' || b == '\r' {
			accum = append(accum, b)
		} else {
			return i, accum, nil
		}
	}
	return 0, nil, nil
}

func consumeNum(data []byte) (int, []byte, error) {
	var accum []byte
	for i, b := range data {
		if '0' <= b && b <= '9' {
			accum = append(accum, b)
		} else {
			return i, accum, nil
		}
	}
	return len(accum), accum, nil
}

func consumeString(data []byte) (int, []byte, error) {
	delim := data[0]
	skip := false
	accum := []byte{data[0]}
	for i, b := range data[1:] {
		if b == delim && !skip {
			return i + 2, accum, nil
		}
		skip = false
		if b == '\\' {
			skip = true
			continue
		}
		accum = append(accum, b)
	}
	return 0, nil, nil
}
</code>
<p><a href="http://play.golang.org/p/dksq4YjJtb">If you play with this code here http://play.golang.org/p/dksq4YjJtb</a>. then you'll see it emit one of each of our tokens.

<p>We still aren't done though. This Scanner while useful doesn't tell us our Token Locations. We need it to tell us the Line and column that each token starts on. To do this we'll use composition again. Only this time we'll compose two structs using <a href="http://golang.org/ref/spec#Struct_types">Go's embedded fields</a>.

<code syntax="go">
type lineTrackingReader struct {
	// Embedded Scanner so our LineTrackingReader can be used just like
	// a Scanner.
	*bufio.Scanner
	lastL, lastCol int // Position Tracking fields.
	l, col         int
}

func newTrackingReader(r io.Reader) *lineTrackingReader {
	s := bufio.NewScanner(r)
	rdr := &lineTrackingReader{
		Scanner = "s,"
	}
	split := func(data []byte, atEOF bool) (advance int, token []byte, err error) {
		// Initiliaze our position tracking fields using a split like a closure.
		if rdr.l == 0 {
			rdr.l = 1
			rdr.col = 1
			rdr.lastL = 1
			rdr.lastCol = 1
		}
		switch data[0] {
		case '(', ')':
			advance, token, err = 1, data[:1], nil
		case '"', '\'': // TODO(jwall) = "Rune data?"
			advance, token, err = consumeString(data)
		case '0', '1', '2', '3', '4', '5', '6', '7', '8', '9':
			advance, token, err = consumeNum(data)
		case ' ', '\n', '\r', '\t':
			advance, token, err = consumeWhitespace(data)
		default:
			advance, token, err = consumeWord(data)
		}
		// If we are advancing then we should see if there are any line
		// endings here
		if advance > 0 {
			rdr.lastCol = rdr.col
			rdr.lastL = rdr.l
			for _, b := range data[:advance] {
				if b == '\n' || atEOF { // Treat eof as a newline
					rdr.l++
					rdr.col = 1
				}
				rdr.col++
			}
		}

		return
	}
	s.Split(split)
	return rdr
}

func main() {
	s := newTrackingReader(strings.NewReader("(foo 1 'bar')\n(baz 2 'quux')"))

	for s.Scan() {
		tok := s.Bytes()
		fmt.Printf("Found token %q at line #%d col #%d\n",
			   string(tok), s.Line(), s.Column)
	}
}

func (l *lineTrackingReader) Line() int {
	return l.lastL
}

func (l *lineTrackingReader) Column() int {
	return l.lastCol
}
</code>
<p><a href="http://play.golang.org/p/_omf7AGefg">You can play with the finished code here http://play.golang.org/p/_omf7AGefg</a>.
