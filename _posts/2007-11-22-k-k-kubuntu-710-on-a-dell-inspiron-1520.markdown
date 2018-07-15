---
comments: true
date: 2007-11-22 20:17:36
layout: post
slug: k-k-kubuntu-710-on-a-dell-inspiron-1520
title: K-k-kubuntu 7.10 on a Dell Inspiron 1520
wordpress_id: 57
tags:
- Geek
- General Computers
- Linux
- Opinion Piece
---

Ahhh... Another day, another distro. The harddrive partitions around here are a bit like the Wizard of Oz; every day a new one joins the merry troupe. Todays turn was the KDE spin on Ubuntu Gutsy. So armed with the standard Kubuntu CD, which serves as a live distro and an install CD in one, we set on the path to enlightment (or should that be KDE - always good to end the week on a bad pun).

Generally, it seems to be recommended practice these days to install Ubunutu or its derivates off the 'alternate' CD when trying to set up an Inspiron to avoid things like incompatible versions of ALSA or wireless drivers working their way into the install. But the Penguin didn't really feel like giving the whole GUI experience a miss. And so the live CD was fired up before you could say 'Holy wireless drivers, Batman!'. A nice desktop link provided a pretty path to installation and within an hour Kubuntu was installed and ready to go.

First thing that was apparent was that the default Kubuntu appearance is quite bland. Especially when compared with something like OpenSuse's nice crisp out-of-the-box KDE look (however nothing will ever get installed waiting around for YAST!). But the good news is that Kubuntu's eye-candy vacuum can be fixed with a bit of tweaking. That wasn't the initial major concern though. The lack of sound and wireless was!

The fix for the sound was easy, running 'sudo apt-get install linux-backports-modules-generic' from the command line delivered sound after a reboot. The wireless was a lot more fiddly to get working - the strange thing is that NetworkManager was picking up all the secured networks and tantilisingly displaying them in its wireless list. But no way in the world was it going to connect to any of them. (BTW, the card is a Intel Pro Wireless 3945). However, the laptop in question is also running Ubuntu Studio out of another partition and it can connect through Gnome's network-admin program without any probs. So there was definitely something fishy up.

Plan A at solving the problem was to install wlassistant (sudo apt-get install wlassistant) in order to try and put a different network program in the firing line. But alas still no connection. Then after a bit of head scratching we decided to install the whole bloody Gnome network admin and try and use that (sudo apt-get install gnome-system-tools) - which can be run via the 'network-admin' command. There was a time there when this was looking like a winning plan but no joy. Weird thing is, and the Irish Penguin has no explaination for this, is that rebooting and connecting via wlassistant did the job! Worked a charm! A lucky charm!!!

Final things on the list was to glam up that gaudy GUI. The install of Gnome's networking stuff had left a few stray icons in the menu so they had to be wisked away as they weren't working anyway. Then a few nice things to do are

* Right-click on the quicklauncher at left of the taskbar and configure it to have a fine big icon size - 28 looked good on the Inspiron. Big icons always look nice in KDE's taskbar, otherwise where's the fun?

* One of the best ways to brighten up the panel is to (right-click on the taskbar and configure) set 'Enable background image' for the panel and select a nice tile. This also puts a pretty sash down the left of the K-menu. Optionally choose 'Colorize to match desktop theme'

* In the system settings keep the Style->Widget Style as 'Polyster' but change the Window Decoration to 'Keramik'

* Change the window background to be a nice soft colour - a very light fawn is nice - and in keeping with the Ubuntu theme...

* And for God's sake pic a nice desktop background!

Along the way, we flicked over to the proprietary NVidia drivers via the restricted driver management without problems. Although it did make all the fonts bigger for some reason - so they had to be tamed again using the following [fix](http://ubuntuforums.org/showthread.php?t=94737)  (note: changing font properties in System Settings isn't enough to fix this). I used a dpi of 75 instead of 100 as the fix did. Another thing that was hard to track down was power management adjustment there's no setting in System Settings - rather it can be found by right-clicking on the battery icon to the right of the task bar and selecting 'Restore' to bring up the dialog - of course!

So what's the verdict after all the hard work is out of the way. Kubuntu is a fine desktop if you're prepared to put in a little effort customising its look and feel. Because of the effort required in prettying it up - Kubuntu initially feels less polished than it's sister Ubuntu. Package management in Adept isn't as smooth as Synaptic. But there are some real pluses out of the K stable. Dolphin has replaced Konqueror as the default file browser and its two pane mode is great. Not quite sure why its taken so long for a two pane file manager to crop up in a modern OS but it's not before time. All the usual great KDE apps from K3B to Amarok are in there. The Penguin's final verdict is that it feels a little more 'bright' and 'fun' than Ubuntu which is more 'finished' but serious.
