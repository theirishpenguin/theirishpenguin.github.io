---
comments: true
date: 2010-06-21 06:52:37
layout: post
slug: deploying-your-qt-on-rails-apps-on-the-n900-maemo
title: Deploying your Qt on Rails apps on the N900 (Maemo)
wordpress_id: 655
tags:
- Geek
- kde
- Linux
- Programming
- RubyIreland
- Rubyonrails
- UbuntuIreland
- gem
- install
- kde
- maemo
- mobile
- n900
- nokia
- rails
- ruby
- rubygems
- sqlite
---

Qt on Rails is a framework to let you turn your Rails sites in desktop applications and harness the power of Ruby! It's not at production level yet but it's certainly possible to have a good play with it and a bit of a hack! If you're not familiar with Qt on Rails then a good place to start is [this blog post](http://www.theirishpenguin.com/2010/06/21/qt-on-rails-v0-1-released-but-is-this-ruby-based-qt-and-kde-app-framework-doomed/) covering the v0.1 release. Also, check out the [github repo](http://github.com/theirishpenguin/qtonrails) for more info on installing Qt on Rails on your desktop and building an application with it.  Here we show you how to deploy Qt on Rails based apps on your N900. One of the goals of Qt on Rails is to provide an easy way for you to develop apps faster for Maemo and, down the road, hopefully MeeGo too!

Note: This blog post may help you figure out how to install any QtRuby application on the N900, not just Qt on Rails apps. Also, this  [QtRuby Maemo wiki article](http://wiki.maemo.org/QtRuby) was particularly useful when I was stumbling along this path!

One thing you will need to install as part of this guide is [Easy Debian](http://wiki.maemo.org/Easy_Debian). Easy Debian greatly expands what you can do with your Maemo device. It basically sticks a full-featured version of Debian on your device. This means 2 things - firstly, for the uber-geeks out there it let's you fire up a Linux desktop on the N900; though it's important to note that your normal Maemo desktop isn't affected by Easy Debian. Secondly, having a full-on Debian available let's you run Linux apps such as Open Office! Sweet! And what rocks is that you can even run these programs without invoking the Easy Debian Linux desktop - in a seamless manner. It's important to note that the user interface to these Easy Debian-based apps behave a differently to a typical native Maemo program; rather they work like a traditional desktop application with a mouse pointer on screen.



### Install Steps

* Note: For simplicity, this guide assumes you are installing an application which stores data using sqlite3. Also, the steps here have been tested against the N900 firmware update PR1.2. If you are using an older version of the firmware you may want to consider updating it.

	
* Firstly, install Easy Debian with the N900's Application Manager

* Install the Easy Debian image via the new Deb Img Install application added to your list of applications

	
  * Note: This is a 1 gig download, but comes with cool stuff like OpenOffice and intergrates pretty seamlessly with your desktop

	
  * Takes an hour or so to download and then extract itself
	
* Open the Debian Chroot terminal (not the usual N900 terminal), which should now be in your list of applications

* Install rubygems, qtruby and  sqlite3 with ruby bindings

      sudo apt-get install rubygems
      sudo apt-get install libqt4-ruby
      apt-get install libsqlite3-ruby
	
* Install the bits we need need from Rails (without installing documentation)
	
      sudo gem install activerecord activesupport activeresource --no-ri --no-rdoc

* Zip up your Qt on Rails application and copy to any directory on to the N900. Note that the Qt on Rails application consists of the entire Rails directory directory including the vendor/plugins/qtonrails directory intact and  a sqlite3 database already created under the db directory). 

If you don't have your own Qt on Rails application to hand then you can create the RadRadio app discussed in the "Make it so, Jim!" section of the [v0.1 release blog post](http://www.theirishpenguin.com/2010/06/21/qt-on-rails-v0-1-released-but-is-this-ruby-based-qt-and-kde-app-framework-doomed/)

In the Qt on Rails v0.1 release there is a bug that accidentally introduces a dependency on a korundum library, which is not needed in this case. [An issue is logged](http://github.com/theirishpenguin/qtonrails/issues#issue/2) against this in the [Qt on Rails Issue Tracker](http://github.com/theirishpenguin/qtonrails/issues) As a workaround, find and remove any occurrences of `require 'korundum4'` in files under the `vendor/plugins/qtonrails/app` directory
	
* Once transferred, simply unzip it on your device. Note: If you saved the zip to the Documents folder on your N900, this can be found under /home/user/MyDocs/.documents when poking around the filesystem

* Finally, via the good ol' Debian Chroot terminal, change directory to the vendor/plugins/qtonrails directory of your app and execute

      ruby1.8 run

* Boom! You should see your Qt on Rails app in all it's glory!

Note there is a [bug](http://github.com/theirishpenguin/qtonrails/issues#issue/6) where you cannot input into a text field when running a Qt on Rails app on the N900 using above technique (seamless mode). As a workaround, open the Qt on Rails app inside of the Debian LXDE desktop (rather than in seamless mode). You can find Debian LXDE in the list of applications on your device. Inside Debian LXDE, open a terminal and run the application as above. Just a quick heads up, sticky keys don't work like you'd expect - you have to [hold down the Shift and Fn keys](http://wiki.maemo.org/Easy_Debian#sticky_keys_hack) to use them.
