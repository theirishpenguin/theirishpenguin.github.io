---
comments: true
date: 2007-04-20 16:54:48
layout: post
slug: use-the-force-to-fix-evil-vistas-bootloader
title: Use the Force to Fix Evil Vista’s Bootloader
wordpress_id: 20
---

Hmmm... Those lovely folks at Microsoft are at it again. This time trying to break my lovely Linux system by killing my bootloader - the clever bit of software which lets you choose whether to boot into Linux or Windows. Cheers guys! You're real sweet!

I bought my machine with Vista pre-installed with about 50 gig spare for Linux. I installed OpenSuse 10.2 into this space, which uses a little program called GRUB to switch between the Windows Vista and OpenSuse Linux when you start up the computer. Somehow Vista managed to overwrite this - I don't know how, as I installed Linux second, but anyway in order to fix you need to do the following

1.) Get yourself a LIVE Linux CD (ie. a linux system that boots of a CD with requiring it be installed on your harddrive). I used the OpenSuse 10.2 Live CD
2.) Boot from this disk and then folllow the brief instructions at the following [link](http://ubuntuforums.org/showthread.php?t=224351). Even though it outlines the process for Ubuntu (a different Linux distribution), it works just as well for OpenSuse 10.2

Happy hacking!
