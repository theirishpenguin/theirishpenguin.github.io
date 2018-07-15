---
comments: true
date: 2007-05-05 06:50:23
layout: post
slug: javascript-tip-of-the-day-when-is-a-width-not-a-width
title: 'Javascript Tip Of The Day: “When Is A Width Not A Width?”'
wordpress_id: 29
tags:
- Geek
- Programming
---

This is a bit of a gotcha for young players in the Javascript game. You have a web page with a DIV which you fill dynamically with, let's say, 5 IMG elements. How do you get the width of the DIV? You can try 

    document.getElementById('divId').width

but it will do you no good. The answer, use

    document.getElementById('divId').offsetWidth

[Here's](http://msdn2.microsoft.com/en-us/library/ms533024.aspx) a handy guide when it comes to DHTML element position and locations.
