---
comments: true
date: 2008-09-14 06:30:39
layout: post
slug: recording-sound-in-kubuntu-810-running-kde-41
title: Recording Sound in Kubuntu 8.10 (running KDE 4.1)
wordpress_id: 77
tags:
- Linux
- Ubuntu
- UbuntuIreland
---

Exciting times ahoy! This weeks mystery was to get sound recording with the minimum of fuss. We're not sure what soundcard is running inside the Dell Inspiron 1520 which was our test laptop but it seems to report itself as an HDA Intel SigmaTel STAC9205 in the system settings. Anyway, the first thing to do was to apt install audacity which can then be used for testing the recording functionality. Not being sure if the laptops builtin in mic had been detected correctly, we jacked in an external microphone into the mic socket.

This didn't produce any encouraging results initially when we tried recording in audacity so we opened up the KDE volume controls by clicking the speaker icon on the taskbar and electing to open the mixer. Unfortunately the GUI controls for the mixer doesn't have the full complement of volume controls so it was the good ol command line to the rescue - typing alsamixer in terminal brings up a nice range of controls. You can navigate between screens of controls with the tab key and jump from control to control using the left/right arrow keys. The trick was to navigate to the two controls marked 'Capture' and bump up the volume (they also need to be activated by pressing the spacebar when you're on the control). Additionally, there were two controls marked 'Digital'. One of these controlled the volume of the mic (via the up and down arrows) and the other switched between analog and digital mode (again via the up and down arrows). We found that the latter had to be set to 'Analog I' for the best result.

Then it was back to audacity to record a bit of chatter - and then lament how weird ones voice sounds when recorded! Now get mixing mon amis!

### QUICK UPDATE (14 Sep 08)

One issue that occurred was that after recording a sample, it couldn't be played back("Error while opening sound device. Please check the output device settings and the project sample rate."). Additionally, a second track couldn't be recorded. The solution to these problems was to open the Preferences dialog and set both the Playback and Record devices to ALSA (default). Reference: http://audacityteam.org/forum/viewtopic.php?f=18&t=3377
