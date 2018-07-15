---
comments: true
date: 2010-11-18 02:11:11
layout: post
slug: installing-ruby-and-rubygems-on-meego
title: Installing Ruby and Rubygems on Meego
wordpress_id: 984
tags:
- install
- meego
- ruby
- rubygesm
---

Thanks to some great people on the Meego mailing lists I can happily show you how to get recent versions of Ruby and Rubygems running on your beloved MeeGo. The steps I present here are simply extracted from the guide at[ http://wiki.meego.com/Quality/QA-tools/TDriver](http://wiki.meego.com/Quality/QA-tools/TDriver)

Once the more recent Ruby releases (1.8.7 and higher) gain more traction in MeeGo they will likely move into the core repository. So, be sure to see if they are there before changing adding/removing repositories as it outlined here.

Warning: You need to disable the MeeGo core repository and enable the testing and development repositories so be sure that you're happy to do this before continuing.

Steps:

    #Remove the MeeGo core repo
    sudo zypper rr core
    
    # Enable the testing repo
    sudo zypper ar http://download.meego.com/live/Trunk:/Testing/standard/Trunk:Testing.repo

    # Enable the dev repo
    sudo zypper ar http://download.meego.com/live/devel:/quality/testing/devel:quality.repo

If you run into trouble remove this last repo with the command. If you do so you will be able to go no further.

    sudo zypper rr devel_quality

    # Install Ruby 1.8.7
    sudo zypper install ruby

    # Install rubygems
    sudo zypper install rubygems

Yay! You're done! This guide would likely not have happened unless the MeeGo conference and its sponsors had not given away free MeeGo netbooks to the smiling attendees. Well done guys! And thank you!
