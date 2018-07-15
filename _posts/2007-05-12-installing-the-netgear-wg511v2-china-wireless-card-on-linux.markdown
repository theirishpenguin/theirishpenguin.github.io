---
comments: true
date: 2007-05-12 14:03:13
layout: post
slug: installing-the-netgear-wg511v2-china-wireless-card-on-linux
title: Installing the Netgear WG511v2 (China) Wireless Card on Linux
wordpress_id: 33
tags:
- Geek
- General Computers
- Linux
---

These instructions are intended to be used to install a Netgear WG511 v2 (China) on a Linux machine that dual boots with Windows. I take no responsibility for anything bad that might happen if you follow this guide (I try to avoid responsibility at every turn).

### PRE-REQUISITES

* Your machine must be a dual boot system
* You must have the wireless card installed and functioning on Windows
* The Windows partition on which you installed the wireless card already must be accessible to the Linux system (my Windows partion had the FAT32 filesystem which made this easy). If not you will first have to find a tutorial that covers this. A quick google on this topic should help. It will require you to update your /etc/fstab file. Here's an article on this file http://www.tuxfiles.org/linuxhelp/fstab.html but as I said googling around might find you even easier tutorials on this.


### ADDITIONAL NOTES

* I performed this on an IBM T22 running Ubuntu Linux 5.10 'Breezy Badger' and also on OpenSuse 10.2. Windows 2000 was also installed as part of my dual boot system.

* As I did this on Ubuntu I used sudo instead of logging in as root. That's what the rest of this guide assumes. On OpenSuse, I used su from the command line in order to become the root user. Depending on your distro you may have to log in as root if it doesn't support sudo.


### INSTRUCTIONS
* Ensure that the wireless driver is installed and working on Windows
* Shutdown and remove your wireless card from it's PCMCIA slot (I'm not sure if this step is needed)
* Boot into your Linux distro
* Install the ndiswrapper packages
* From the command prompt (whilst still logged into Linux), search for the driver on the windows partition (storing the results in a file for easy viewing). For example (your path to Windows will probably be different)

      find /mnt/windisk/ -iname '*.inf'>inf_files_on_windows.txt

* Open inf_files_on_windows.txt in your favourite editor and look for the matching driver. It should be something like WG511v2.INF (this may vary on your system). Do some searches on 'WG' or on '511' to track it down. Note: You will need the full path to this file for the next step

* From the command line type (but make sure the path matches the one you found in the previous step and remember to use the FULL path)

      sudo ndiswrapper -i /mnt/windisk/winnt/inf/WG511v2/WG511v2.INF

* N.N.B. Sorry to labour the point but remember you need to reference the ORIGINAL driver file on your windows partion; you can't copy it over to your Linux partion and reference it from there (I tried!). This is at the heart of the 'dual boot' system requirement (perhaps you know a way around this - I'm not terribly clever at this sort of thing!)

* Type the following command to see if your installation was successful

      sudo ndiswrapper -l

  A message like this indicates success

      Installed ndis drivers:
      wg511v2 driver present

   A message like this indicates failure (sorry!)
      Installed ndis drivers:
      wg511v2 invalid driver!

* I really hope the last step worked. If not you'll have to re-google and try another solution (double check that you've followed this guide correctly first). If so, plug your wireless card into the PCMCIA slot. Then type 'sudo ndiswrapper -l' again. You should get

      Installed ndis drivers:
      wg511v2 driver present, hardware present

* I can remember the excitment when I saw the above line. Share the fun! The rest of this should be a doddle (but don't count your chickens!)

* Load the ndiswrapper module into the kernel using

      sudo modprobe ndiswrapper

* To see that this worked (the green LED on your card should now have flicked into life) run the command 'dmesg' and you should get some info on how your wireless card has been installed, for example

      ndiswrapper version 1.1 loaded (preempt=no,smp=no)
      ndiswrapper: driver wg511v2 (NETGEAR,02/22/2005,3.1.1.7) loaded[4296766.069000] PCI: Enabling device 0000:22:00.0 (0000 -> 0002)
      ACPI: PCI Interrupt 0000:02:02.0[A] -> Link [LNKA] -> GSI 11 (level, low) -> IRQ 12
      PCI: Setting latency timer of device 0002:02:00.0 to 64
      ndiswrapper: using irq 12
      wlan0: ndiswrapper ethernet device 01:0f:b5:8e:4e:2d using driver wg511v2, configuration file 11AB:1FAA:2385:4E00.5.conf
      wlan0: encryption modes supported: WEP, WPA with TKIP, WPA with AES/CCMP

* From the above output I can now tell that my card has been assigned to the 'wlan0' interface. Yours may differ.

* Your card is now ready for use. You can use the 'iwlist' command to scan for connections. For example (replace 'wlan0' with the interface that your card in the dmesg output above),

      iwlist wlan0 scan

* One final thing, set the 'sudo modprobe ndiswrapper' command to be run on each boot (how you do this will depend on your disto). Otherwise, you'd have to run this command each time you log in.

* I actually haven't used my wireless card yet (in fact, I'm just writing this article 10 seconds after completing these steps I'm describing!) but apparently Pawel Nawrocki's Wireless Assistant is a great tool. So says Linux Format at http://www.linuxjournal.com/article/8398 which might have a link to it

* Happy networking. Why don't you go and listen to the following [Free Software Song](http://www.gnu.org/music/free-software-song.html) to top off the perfect day.

### One final note

I was never able to connect to networks protected by the basic encryption WEP but had no problems connecting to networks using the more more secure encryption WPA. This could just be me...

