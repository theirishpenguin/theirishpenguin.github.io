---
comments: true
date: 2009-09-09 09:34:13
layout: post
slug: packaging-ruby-apps-for-ubuntu-dissecting-an-existing-ruby-ubuntu-package
title: 'Packaging Ruby Apps for Ubuntu: Dissecting an existing Ruby Ubuntu Package'
wordpress_id: 260
tags:
- Geek
- Linux
- Programming
- RubyIreland
- Rubyonrails
- Ubuntu
- UbuntuIreland
---

One of the best ways to learn about how a Ubuntu package is put together is reverse engineer the package into it's constituent components. We are going to take a look at how to do this for the chef application and it's related libchef library is packaged as a Debian package.

* Visit the page [http://packages.ubuntu.com/karmic/ruby/chef](http://packages.ubuntu.com/karmic/ruby/chef)
* Under the Download chef section, download the package via the 'All' link into a directory called chef
* Visit the page [http://packages.ubuntu.com/karmic/ruby/libchef-ruby1.8](http://packages.ubuntu.com/karmic/ruby/libchef-ruby1.8)
* Under the Download libchef-ruby1.8 section, download the package via the 'All' link into a directory called libchef1.8

From the following guide ([http://www.g-loaded.eu/2008/01/28/how-to-extract-rpm-or-deb-packages](http://www.g-loaded.eu/2008/01/28/how-to-extract-rpm-or-deb-packages)) you can learn how to 'unzip' a Debian package. This is easy as they are pure ar archives. Here's what we need to do

* In the chef directory, run the commands

      ar vx chef_0.7.8-0ubuntu2_all.deb
      tar -zxvf data.tar.gz

* In the libchef1.8 directory, run the commands

      ar vx libchef-ruby_0.7.8-0ubuntu2_all.deb
      tar -zxvf data.tar.gz

Now you can study the layout of the of the data payload of the package (this is where to look in order to study the anatomy of the application as it was being packaged). This layout is what will be of most interest to you.

If you have an application in a particular programming language that you wish to package, pick a similar application for which a package already exists and dissect it as shown above. Then bend your app into a similar shape in terms of directory layout before attempting to package it. To find out more about how to create your own Ubuntu packages check out this great video by Horst Jens [Ubuntu: Making a .deb package out of a python program](http://showmedo.com/videotutorials/video?name=linuxJensMakingDeb). It's worth the effort of watching it to the end!

Happy packaging!
