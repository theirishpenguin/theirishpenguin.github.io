---
comments: true
date: 2010-07-25 06:01:35
layout: post
slug: awesome-linux-media-center-using-xbmc
title: Awesome Linux Media Center using XBMC
wordpress_id: 841
tags:
- Linux
- media center
- music
---

One of things I have been doing lately is rediscovering my music - inspired by talking to the some of the [Amarok](http://amarok.kde.org/) guys at Akademy this year! So I decided to go on a search for an Open Source Media Center solution and up popped [XBMC](http://xbmc.org/). Now this project isn't related to Amarok but that doesn't stop it being way too cool for school! I've being tinkering with it for just a few days and it just works like a dream.

### Installation on Kubuntu is simple

* I just following the [Install XBMC on Ubuntu HOWTO](http://wiki.xbmc.org/index.php?title=HOW-TO_install_XBMC_for_Linux_on_Ubuntu,_a_Step-by-Step_Guide)

* In (KDE's) System Settings -> Autostart, added XBMC Media Center to startup automatically on computer startup

* From within XBMC itself, went to System -> Settings -> System -> Video Output and set the Resolution to be Windowed (as I usually want to be able to access my KDE desktop at any time)

* Initially you will have no music library. Instead you will add a directory location containing your music via Add Source. Then you can browse the added location and choose to _Scan Item to Library_ to build up your music library

* By visiting System -> Settings -> Network -> Services you can _Allow control of XBMC via HTTP_ by setting Port, Username and Password. If you know the IP address of the machine you are running XBMC on then you can simply browse to http://YOUR_MACHINE_IP_ADDRESS:PORT from any web browser enabled device to control your media center (for example http://192.168.1.7:6666). Note: XBMC must be running on the machine for this to work

* Once you have your music library set up, you will notice that you cannot access it through the web interface. To enable this, simply edit `~/.xbmc/userdata/sources.xml` by adding the following to the `<music>` element

      <source>
      <name>Library</name>
      <path>musicdb://</path>
      </source>

Of course, when I don't need to a complete Media Center solution and just want to rediscover my music I fire up my beloved Amarok :-)
