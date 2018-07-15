---
comments: true
date: 2007-04-20 19:33:33
layout: post
slug: installing-the-smart-package-manager-on-opensuse-102-linux
title: Installing the SMART Package Manager on OpenSuse 10.2 Linux
wordpress_id: 21
tags:
- Geek
- Linux
---

Easy installing of software is the make-or-break aspect of any operating system. This is no different with Linux. Far and away, in my humble opinion, the best tool for this (on an rpm based system) is SMART. This quick post just overviews the steps I took to get it installed on my machine, as some of the instructions deviated from the [SMART on Suse wiki](http://susewiki.org/index.php?title=SMART_Package_Manager).

I went into Suse's main configuration tool called YAST and checked made sure that the following were installed as pre-requisites
* python-xml
* python-elementtree
* rpm-python

Then I went to the command line and typed
> su
> rpm -ihv http://ftp.skynet.be/pub/suser-guru/smart/10.2/i586/smart-latest.rpm

This did the hard work of installing smart which then asked a series of questions as to what sources to use for installing software (called channels). I said yes to everything except any channels with KDE in the title as the KDE channels can contain 'developmental' bleedin edge software which can destabilise your system (I wasn't sure if it was ok to say yes to the KDE-backports so I just err'ed on the side of caution and said no).

Then came the tricky bit - which is the reason I'm writing this blog post - installing a user interface for SMART. This is because when I followed the instructions on the 'SMART on Suse wiki' (ie. the above link) I typed

> smart install smart-gui

but got the error...

> Computing transaction... error: Can't install smart-gui 0.50-1 guru.suse102@i686: no package provides python-gtk

The fix for this is to install python-gtk the same way as the prerequisites (python-xml , python-elementtree, rpm-python) using YAST. I found this answer at the following [forum thread](http://www.suseforums.net/index.php?s=45e9658b8fb46fe31d611f9f87b4f935&showtopic=27845&pid=148595&st=0&). Once that's complete type the following

> smart install smart-gui

and agree to its demands. Here presto! You're done... and now have the easiest way to install software in town! To run SMART just type

>sux -c "smart --gui"

I was doing this on a 32 bit machine. If your architecture is different you might want to refer to the
SMART on Suse wiki, which also has a lot more detail on the powerful ways to configure and use this wonderful little program.



