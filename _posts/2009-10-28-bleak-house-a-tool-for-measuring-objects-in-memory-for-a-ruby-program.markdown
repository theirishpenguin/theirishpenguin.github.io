---
comments: true
date: 2009-10-28 02:41:15
layout: post
slug: bleak-house-a-tool-for-measuring-objects-in-memory-for-a-ruby-program
title: Bleak House - A Tool for measuring Objects in Memory for a Ruby Program
wordpress_id: 312
tags:
- Geek
- Programming
- RubyIreland
- Rubyonrails
---

Bleak House is a tool that tells us
- How many Slots there are in total at a point in time in a Ruby program
- How many Slots in total are filled
- How many Slots in total are empty (free)
- How many Filled Slots can be attributed to a particular line of code







Bleakhouse can be used to tell you if program is holding on to objects that it should be relinquishing. But it doesn't tell you how much data is stored in memory for the 'meat' of the object (ie. that 50MB of data in a 50MB String). Just because you know there is a Filled Slot exists - you don't know if the data in memory that correlates back to that Slot is 1MB, 10MB or 100MB.







However, if you repeat a series of a specific set of operations a small number of times, measuring with Bleakhouse, and then restart the server with Bleak house and repeat the operations a large number of times and see a big difference in the number of filled slots can tell that your program is holding onto objects (references) that it should not. Of course, if your program is supposed to keep hold of an increasing number of references (such as a global variable or a singleton that keeps accumulating references for the duration of your program) then this would be expected. Though you might want to double check your design. You will be able to see the cause of the problem from the detailed breakdown of which lines of code were the biggest offenders in terms of creating objects. If you see a large number of free slots (relative to the number of filled slots) then this means that at some point in your program a lot of objects existed (possibly due to a spike in application usage) but then reduced.







Does the free slots count matter? Well, yes because there is an memory overhead due to each free slot that exists - how much depends on your particular system. If your system has a slot size of 20 bytes then every one million free slots costs you an additional 20MB that is not being utilised. This becomes a problem if your application is subject to large but infrequent spikes in the number of objects that exist within your program a particular moment in time because the free slots are taking up significant amounts of memory even when your application is twiddling its thumbs between the spikes.

