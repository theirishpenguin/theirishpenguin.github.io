---
comments: true
date: 2010-11-20 01:14:50
layout: post
slug: installing-ruby-on-rails-on-meego-with-sqlite
title: Installing Ruby on Rails on MeeGo with SQLite
wordpress_id: 987
tags:
- Programming
- RubyIreland
- Rubyonrails
- install
- meego
- qt
- rails
- ruby
- sqlite
---

This post will go through installing Ruby on Rails 2.3.2 on MeeGo - though it should likely work for any version of Rails, including Rails 3 (though the actual Rails commands at the end of this guide will be a little different). Firstly go through the [Installing Ruby and Rubygems on MeeGo](http://www.theirishpenguin.com/2010/11/18/installing-ruby-and-rubygems-on-meego/) guide to get at least Ruby 1.8.7 on your system and then carry out the following steps.

PRE-REQUISITES

The above guide requires you to disable the core repository and then enable the devel and testing repositories. I found that when following the below steps, I would get an error trying to install sqlite3 gem itself - saying that the sqlite3.h header could not be found. I had to run the following commands first

      # Update all packages on the system
      
      sudo zypper update
      
      # Then the chrome browser would not work saying
      
      [declan@declan-desktop grr]$ chromium-browser

      /usr/lib/chromium-browser/chromium-browser: error while loading
      shared libraries: libicuuc.so.42: cannot open shared object file: No 
      such file or directory

      # To fix this, I had to update chromium-browser separately
      
      sudo zypper update chromium

Ok, so onto the actual install steps for Rails and SQLite3...

RAILS INSTALLATION

      #Install ruby and sqlite development headers (as we'll be using
      sqlite as our backend)
      
      sudo zypper install ruby-devel
      
      sudo zypper install sqlite-devel
      
      # Install tools for building C-based gems
      
      sudo zypper install make # Not 100% sure that make is needed
      
      sudo zypper install gcc
      
      # Install sqlite3 gem for ruby
      
      sudo zypper install sqlite3-ruby
      
      # Install Rails
      
      sudo gem install rails -v 2.3.2
      
      # Create a new Rails application
      rails grr
      
      # Create a thing (ok, more correctly called a resource) in Rails
      
      cd grr
      
      ./script/generate Animal name:string
      
      # Create the database
      
      rake db:migrate
      
      # Fire up the Rails web server
      
      ./script/server
      
      # And then browse to your site in the web browser - http://localhost:3000/animals

Hurrah! Everything works! (At least I hope it did!). Happy Rails development!
