---
comments: true
date: 2013-08-02 11:08:11
layout: post
slug: batshift-crazy
title: Batshift Crazy - Basic Binary Number Representation in Javascript
wordpress_id: 1049
image: https://upload.wikimedia.org/wikipedia/commons/c/cf/Binary_Code.jpg
tags:
- Opinion Piece
- Dublin Code Kata
- ireland
- rails
- ruby
---


In today's [Dublin Code Kata](http://www.meetup.com/dublin-code-kata/), we revisited a bit of classic Comp Sci - integer vs binary representation of numbers! And I learned that converting integers to binary numbers isn't all that hard in Javascript :)

<a title="By Cncplayer (Own work) [CC BY-SA 3.0
(http://creativecommons.org/licenses/by-sa/3.0)], via Wikimedia Commons"
href="https://commons.wikimedia.org/wiki/File%3ABinary_Code.jpg"><img
width="512" alt="Binary Code"
src="https://upload.wikimedia.org/wikipedia/commons/thumb/c/cf/Binary_Code.jpg/512px-Binary_Code.jpg"/></a>

For example, to convert the integer 4 to the binary number 100 you use...

    (4 >> 0).toString(2) # gives "100"

And if you want to do chopping of right most digits change the 0 to the number of digits you want to chop off...

    (4 >> 1).toString(2) // gives "10"
    (4 >> 2).toString(2) // gives "1"

Or if you want to append zeros, use the opposite...

    (4 << 0).toString(2) // still gives "100"
    (4 << 1).toString(2) // still gives "1000"
    (4 << 2).toString(2) // still gives "10000"

These are called right shift (>>) and left shift operators (<<) and there is a variation on the right shift called a zero-fill right shift (>>>), as opposed to a sign-propagating right shift (good old >>). The difference becomes interesting when you deal with numbers that don't fit into a 32 bit integer (the upper bound being the magical [2147483647](http://en.wikipedia.org/wiki/2147483647) ).

So if we take a cool two and a half billion we see

    (2500000000 >> 0).toString(2) // gives "-1101010111111010000011100000000"
    (2500000000 >>> 0).toString(2) // gives "10010101000000101111100100000000"

And that all stemmed from today's enjoyable challenge [A Diversion](http://codekata.pragprog.com/2007/01/code_kata_fifte.html). Thanks to [Prag Dave](https://twitter.com/pragdave) for sharing! And thanks to [Miles McGuire](https://twitter.com/_minuteman3) for bringing the bitshift brains and explaining the more esoteric cases!

Here's some more on [bitwise operators](http://en.wikipedia.org/wiki/Bitwise_operation) and more on [bitwise operators in Javascript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Operators/Bitwise_Operators).
