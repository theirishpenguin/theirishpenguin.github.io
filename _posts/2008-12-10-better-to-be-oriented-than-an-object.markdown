---
comments: true
date: 2008-12-10 06:39:02
layout: post
slug: better-to-be-oriented-than-an-object
title: Better to be Oriented than an Object
wordpress_id: 41
tags:
- Programming
- RubyIreland
---

Bit of a mixed bag of thoughts going into this post. Originally it was motivated by a couple of interesting points that I came across [a bunch of ideas on programming by Kristian Dupont](http://www.chrylers.com/top-ten-of-programming-advice-to-not-follow) but then it turned into one of those link hopping sessions where you end up click through a wealth of interesting material.

### A Tip or Two for your Troubles

Kristian outlined a good test to determine if adding a comment to your code is justified saying that "they should contain the word 'because'. This way, you know that you are answering a _why_ rather than a _what_." That's a great test I think. If your comment fails the test then you may well be more in need of a refactor than a comment.

Secondly, when thinking about the classes you plan to use in your code, especially domain models, bear in mind that you're not actually trying to model the real world in a physical sense. For example, if you're writing software for a car dealership and one of your classes is going to be a car remember "You're not implementing a car. You're probably implementing a record of a car which can carry a number of stock items from one city to another, with a certain mileage and speed." The key thing is the context of what you're trying to implement and focus on that - often the real world will map nicely to your domain model but don't force things where doesn't. To shoehorn irrelevant aspects of the physical world into your models doesn't make it "more object oriented" or more correct - quite the reverse. Generally, this in not a problem with the attributes for your models, rather it is a problem with relationships and in particular with inheritance. Should a subclass really be a subclass - just because it is in the real world doesn't necessarily mean that your software be designed on the foundation that it is. This brings on nicely onto the other article, [The Rise & Fall of Object Orientation](http://www.informit.com/guides/content.aspx?g=cplusplus&seqNum=84), which ended up being another inspiration for this post.

### What is Object Oriented these days anyway?

Danny Kalev argues that traditional OO is something that is less and less likely to be found in areas such as STL library of C++, as techniques such as inheritance give way to more template driven styles of programming. The problem he states "is that a member function is useful only for a single class" and goes on to highlight how this doesn't work well for things such as a library of containers.

"If each container class defines its own size() member function, you will end up writing numerous size() functions that basically do the same thing."

Better to use a standalone function to solve the problem which can be used across the board by any class irrespective of inheritance hierarchies. It isn't just C++ that has looked to functional programming techniques to solve problems that traditional OO couldn't deliver on. Languages such as Ruby have effectively made blocks and closures one of the core and most used features of the language. All iteration is done through blocks and lamba functions can solve tricky problems in an elegant manner.

It seems that traditional OO struggles most with collections but works well enough for single objects. [Neal Ford](http://memeagora.blogspot.com/2008/10/library-oriented-programming.html) thinks that Object Oriented Development is the wrong way to even frame the question of code reuse. Instead the focus should be on Library Oriented Development. “Ultimately, the class is just too fine grained to really achieve reuse, but libraries can.” On Java he states that while it “is a library oriented language, no good facilities exist within the language to manage libraries" and notes it sorely lacks a fixed directory structure such as in Ruby on Rails, where plugin developers know the layout of the projects they will be interfacing with from the get go.

Whether you prefer to consider your approach to software development an Object or Library Oriented approach it does seem that the modern developer will be drawing on a wide range of programming paradigms that go beyond traditional OO philosophy. In a hotly debated and opinionated field, it appears that the one true killer approach has not yet emerged to truly simplify and streamline development. At least it will continue to provide software developers, designers and architects with plenty to debate during their coffee breaks for years to come!
