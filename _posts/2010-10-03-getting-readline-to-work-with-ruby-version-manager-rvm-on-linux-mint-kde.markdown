---
comments: true
date: 2010-10-03 05:17:02
layout: post
slug: getting-readline-to-work-with-ruby-version-manager-rvm-on-linux-mint-kde
title: Getting readline to work with Ruby Version Manager (RVM) on Linux Mint KDE
wordpress_id: 941
tags:
- Programming
- RubyIreland
- Rubyonrails
- Ubuntu
- Linux
- mint
- readline
- ruby
- Ubuntu
---

I couldn't get readline to be picked up using the 'rvm package install readline' command. So instead I had to install the readline development headers as a Debian package

`sudo aptitude install libreadline6-dev`

And then tell rvm about the /usr directory when installing ruby

(Note: I had run 'rvm package install zlib' and 'rvm package install openssl' before running this next command)

`rvm install 1.8.7 -C --with-zlib-dir=$HOME/.rvm/usr --with-openssl-dir=$HOME/.rvm/usr --with-readline-dir=/usr`

This solution should also work for Ubuntu.
