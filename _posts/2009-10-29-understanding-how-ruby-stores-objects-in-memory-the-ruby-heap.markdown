---
comments: true
date: 2009-10-29 00:54:48
layout: post
slug: understanding-how-ruby-stores-objects-in-memory-the-ruby-heap
title: Understanding how Ruby stores objects in memory - the Ruby Heap
wordpress_id: 310
tags:
- Programming
- RubyIreland
- Rubyonrails
---

Ruby has it's own heap management which actually consists of several 'Ruby Heaps' to manage objects created during the execution of a Ruby program; this is separate from the System Heap for your Operating System. Each individual Ruby Heap contains Slots, with each Slot able to one reference one object.

The entire space that an object takes up in memory ***is not stored inside the Slot***. Rather each Slot is a small fixed size space which can be thought of as the Ruby interpreter's handle a location in memory. This location exists outside of the Ruby Heap itself and contains the real 'meat' of the object. To be clear, if you have a 50MB string - the 50MB of data is stored outside of Ruby's Heap. If you really want to know the story of the 50MB, the space for it is actually allocated by something like the malloc command in C (as good ol' Ruby is written in C) and then stored on the System Heap. The Slot in the Ruby Heap simply contains a reference to that memory location on the System Heap which contains the 50MB of data.

Here's an example. Let's say that a Ruby program creates a single string of 50MB
* A single free Slot in a Ruby Heap becomes filled
* Memory to store the 50MB of data that makes up the string itself is allocated in memory and put on the System Heap (outside the Ruby Heap!) and a reference to this location is stored in the Filled Slot on the Ruby Heap
* There comes a point in time when this string is no longer needed. This slot is garbage collected on the next GC iteration
* The Filled Slot is turned into a free slot. The 50MB of data in memory referred to by the slot is also freed and returned to the Operating System

Ruby starts of with a minimal set of Ruby Heaps. These are managed by by a Ruby Heap list. Ruby creates Ruby Heaps when needed and frees Ruby Heaps back to the OS when no longer needed (the latter is done in a sub-optimal manner - more on this later). Each Ruby Heap created will be 1.8 times the size of the previous heap. In other words, it will contain 1.8 times the number of slots of the previous heap. Ruby's Garbage Collector, periodically iterates through the Ruby Heaps and frees up any Slots as appropriate (and also the memory that an object really occupies which is referenced by the Slot - ie. the 50MB data of the String) back to the system. Once a GC iteration is complete, some of the Slots that were filled will now be empty - known as Free Slots. Remember that we said that Ruby's Heap management actually consists of many Ruby Heaps. Well if one of these Ruby Heaps consists of only Free Slots then the Ruby Heap itself will be freed back to the Operating System.

There is a problem with this last statement however - if a Ruby Heap contains mostly Free Slots and one Filled Slot then it will not be freed. You could have many Ruby Heaps in this state. As long as a Ruby Heap contains even one Filled Slot it will not be returned to the Operating System. It just takes one bad apple to spoil everything! What would be nice is if some sort of Heap Compaction (kind of like disk fragmentation) took place where all Filled slots were pushed together into completed filled Ruby Heaps. This would leave you with completely filled Ruby Heaps, one semi-filled Ruby Heap and then a bunch of completely empty Ruby Heaps. The completely empty Ruby Heaps could then be freed, releasing precious memory back to the Operating System. Alas the current mainstream Ruby interpreter does not do this.

### References

* [How the Ruby Heap is Implemented](http://izumi.plan99.net/blog/index.php/2007/10/12/how-the-ruby-heap-is-implemented/) Phusion Passenger's Hong Lai gives a great explanation of the Ruby Heap - the banner may not be quite suitable for work. Fortunately, there's a censor button :-)

* [Fine tuning your garbage collector](http://www.coffeepowered.net/2009/06/13/fine-tuning-your-garbage-collector/) Chris Heald explains some of the settings around garbage collection

* [Ruby's Garbage Collections effect on Ruby on Rails](http://blog.pluron.com/2008/01/ruby-on-rails-i.html) Pluron Inc's blog discusses so of the knock-on effects of Ruby GC on Rails and importantly mentions the 8 MB memory allocation tigger for the garbage collector
