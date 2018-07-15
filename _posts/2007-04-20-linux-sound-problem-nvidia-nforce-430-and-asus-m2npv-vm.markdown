---
comments: true
date: 2007-04-20 20:08:31
layout: post
slug: linux-sound-problem-nvidia-nforce-430-and-asus-m2npv-vm
title: 'Linux Sound Problem: Nvidia nForce 430 and Asus M2NPV-VM'
wordpress_id: 22
tags:
- Geek
- General Computers
- Linux
---

This is just a quick post covering a sound problem I encountered when running OpenSuse 10.2 with Nvidia nForce 430 and Asus M2NPV-VM. The solution that worked for me is to open the /etc/modprobe.conf.local file and make sure it includes the options line below...

 
    #
    # please add local extensions to this file
    #
    
    options snd-hda-intel position_fix=1 model=3stack


This did the job nicely. I found the solution [here](http://www.latenightpc.com/blog/archives/2006/11/10/sound-quirk-with-the-nvidia-nforce-430-and-asus-m2npv-vm/), which has a lot more detail.


