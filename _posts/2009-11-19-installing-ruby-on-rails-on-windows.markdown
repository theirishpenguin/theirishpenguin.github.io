---
comments: true
date: 2009-11-19 12:19:39
layout: post
slug: installing-ruby-on-rails-on-windows
title: Installing Ruby On Rails on Windows
wordpress_id: 354
tags:
- Programming
- RubyIreland
- gem
- install
- rails
- ruby
- rubygems
- sqlite
- vista
- windows
---

There were a couple of great outcomes from the first Free Ruby Lesson we ran in the Havana cafe on Dublin's Georges St last Monday. The first was getting everyone hacking with the Rails stack and some practical examples in double quick time. The second was managing to get RoR installed on Windows Vista as the lesson rumbled on in the background. Here's how Rails conquered Vista.

We kicked off by following the instructions on the rails wiki (link no longer available). It's worth paying careful attention to anywhere it says to set path variables. If you find that you are getting an error that says that you version of rubygems is not recent enough (and you can't get rubygems to update itself) then you can install an older version of Rails, for example 2.3.2, using the following from the command line

    
    gem install rails -v 2.3.2


(Note: If you have already installed a different version of rails you can uninstall it first by using 'gem uninstall rails').

The big problem however was getting sqlite3 working. We did install the SQLite Command Line Tool and the SQLite DLL as the Rails Wiki instructions said to - but to no avail. We kept getting a popup error saying that the sqlite3 dll was not found and to please consider reinstalling. Fortunately, we gambled on one of the answers on [StackOverflow](http://stackoverflow.com/questions/515639/ruby-cannot-find-sqlite3-driver-on-windows). Basically the solution was from the command line

    
    gem uninstall sqlite3-ruby
    gem install sqlite3-ruby --source http://gems.rubyinstaller.org


And with that we were away! The final thing was to get a nice friendly IDE installed so we plumbed for Netbeans on the [Netbeans Downloads page](http://netbeans.org/downloads). Look out for the special Ruby version of Netbeans which is one of the links around the middle of the downloads page.

Anyway, that's all for this week. Happy Ruby hacking!
