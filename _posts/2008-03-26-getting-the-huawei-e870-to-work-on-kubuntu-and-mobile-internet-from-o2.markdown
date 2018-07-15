---
comments: true
date: 2008-03-26 10:48:46
layout: post
slug: getting-the-huawei-e870-to-work-on-kubuntu-and-mobile-internet-from-o2
title: 'Getting the Huawei E870 to work on Kubuntu (and Mobile Internet from O2) '
wordpress_id: 69
tags:
- Geek
- General Computers
- Linux
- Opinion Piece
- UbuntuIreland
---

It's a shiny express card and it promises Internet free from cables, plugs and sockets but will it work on your pretty Kubuntu laptop? Let's hope so. This guide worked for me and hopefully it'll work for you too!

Now before we start let me tell you my setup. I've got this working on a Kubuntu based Dell Inspiron using O2 as my network provider. It did not work on a separate Dell Vostro running Ubuntu 7.10 (however I did get it working on a different Kubuntu 7.10 Dell Inspiron laptop). So I'm not sure whether that was a Ubuntu or Vostro thing or just bad luck. Also, note that the below approach worked for me when setting up Huawei's E220 USB modem too.

In any case, here's the 6 step plan to happiness
1.) Download the huaweiAktBbo-i386.out file
2.) Create the /etc/chatscripts/huawei-e220.chat file
3.) Create the /etc/ppp/peers/huawei-e220 file
4.) Create the /etc/wvdial-huawei.conf
5.) Edit the /etc/resolv.conf
6.) Create and tailor the /home/username/bin/connectme script (and chmod it!)
7.) Tip of the day - lose the Edge!

**1.) Download the huaweiAktBbo-i386.out**
This can be done by visiting [http://www.kanoistika.sk/bobovsky/archiv/umts/](http://www.kanoistika.sk/bobovsky/archiv/umts/) and downloading the file huaweiAktBbo-i386. If you really want you can also build it from the C source provided (in order to build it you will need to have a C compiler and some basic tools on your system). NB: Copy the huaweiAktBbo-i386.out file to your /home/username/bin directory after downloading. If you don't have a bin folder under your home directory then create one ('mkdir /home/username/bin'). Also ensure that it is in your $PATH environment variable. Try echo $PATH and if you don't see it listed add the following line to your /home/username/.bashrc file

export PATH=$PATH:/home/username/bin

To get this change immediately picked up by your shell run the command 'source ~/.bashrc'. This something I didn't learn for years!!! D'oh!

**2.) Create the following /etc/chatscripts/huawei-e220.chat file**

    
    TIMEOUT 3
    ABORT BUSY
    ABORT 'NO CARRIER'
    ABORT VOICE
    ABORT 'NO DIALTONE'
    ABORT 'NO DIAL TONE'
    ABORT 'NO ANSWER'
    ABORT DELAYED
    "" ATZ
    OK ATQ0V1E1S0=0&C1&D2
    OK ATDT*99#
    CONNECT ""


**3.) Create the /etc/ppp/peers/huawei-e220 file**

    
    /dev/ttyUSB0
    460800
    noipdefault
    defaultroute
    persist
    noauth
    nodetach
    usepeerdns
    connect "/usr/sbin/chat -vf /etc/chatscripts/huawei-e220.chat"


**4.) Create the /etc/wvdial-huawei.conf**

    
    [Dialer Defaults]
    Modem = /dev/ttyUSB0
    #Baud = 3600000
    Baud = 7200000
    Init1 = ATZ
    Init2 = ATQ0 V1 E1 S0=0 &C1 &D2
    Init3 =
    Area Code =
    Phone = *99#
    Username = ppp
    Password = ppp
    Ask Password = 0
    Dial Command = ATDT
    Stupid Mode = 1
    Compuserve = 0
    Force Address =
    Idle Seconds = 0
    DialMessage1 =
    DialMessage2 =
    ISDN = 0
    Auto DNS = 1


**5.) Edit the /etc/resolv.conf file**
Add the following entries at the top of this file (they are O2's nameservers)

    
    nameserver 62.40.32.33
    nameserver 62.40.32.34


**6.) Create the and tailor the /home/username/bin/connectme script as follows (and chmod it!)**
Note: See step 1 for more instructions if you don't have a bin folder in your home directory

    
    #!/bin/bash
    sudo /home/username/bin/huaweiAktBbo-i386.out # CHANGE THIS TO YOUR 'USERNAME'
    sleep 3 # wait for the USB host to settle down...
    sudo wvdial --config /etc/wvdial-huawei.conf
    #/usr/sbin/pppd call provider


Then just do a 'chmod u+x /home/username/bin/connectme' from the command line (to allow you to run 'connectme' from the command line directly) and hopefully you should be ready to rock! The next step is to insert your E870 into the express slot. You might start to see Linux picking up the the devices and popping dialogs asking you if you want to mount the device (you should select 'Cancel' for them all).Wait about 5 seconds for it to steady itself and then run 'connectme' from the command line. You should see

    
    Hladam HUAWEI E220 a prepnem na modem - bbo 06
    4 set feature request returned 0
    Prepnute-OK, Mas ttyUSB0 ttyUSB1 (cez usbserial vendor=0x12d1 product=0x1003)
    pozri /proc/bus/usb/devices
    WvDial<*1>: WvDial: Internet dialer version 1.56
    WvModem<*1>: Cannot get information for serial port.
    WvDial<*1>: Initializing modem.
    WvDial<*1>: Sending: ATZ
    WvDial Modem<*1>: ATZ
    WvDial Modem<*1>: OK
    WvDial<*1>: Sending: ATQ0 V1 E1 S0=0 &C1 &D2
    WvDial Modem<*1>: ATQ0 V1 E1 S0=0 &C1 &D2
    WvDial Modem<*1>: OK
    WvDial<*1>: Modem initialized.
    WvDial<*1>: Sending: ATDT*99#
    WvDial<*1>: Waiting for carrier.
    WvDial Modem<*1>: ATDT*99#
    WvDial Modem<*1>: CONNECT
    WvDial<*1>: Carrier detected.  Starting PPP immediately.
    WvDial: Starting pppd at Tue Mar 25 21:22:08 2008
    WvDial: Pid of pppd: 11465
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: Using interface ppp0
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: local  IP address 62.40.58.185
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: remote IP address 10.64.64.64
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: primary   DNS address 62.40.32.33
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: secondary DNS address 62.40.32.34
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]


If you want to disconnect from the web simply press Ctrl-C twice to kill it off. The first time you press it, it talks of wanting to exit gracefully - but better to press it a second time and exit effectively ;-)

You'll see the following

    
    Caught signal 2:  Attempting to exit gracefully...
    WvDial<*1>: Terminating on signal 15
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: Connect time 8.6 minutes.
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: pppd: H���h�[06][08]`�[06][08]
    WvDial<*1>: Disconnecting at Tue Mar 25 21:30:45 2008


**7.) Tip of the day - lose the Edge!**
Disclaimer: this is just my opinion as to the performance of the Edge network so O2 lawyers keep your knickers on (however Apple iPhone suckers, enjoy the sheer speed of the Edge network, getting dripfeed broadband at 1500 Euros a year!). In stark contrast though, my experience with the HSDPA network have been good. Yes, as you may have already guessed, the Edge network was not really delivering for me. But a friend of mine showed me how to change your O2 broadband Express card (or USB modem) settings so that it not even bother connecting if it can't get a proper UTMS or HSDPA signal. For this you need a Windows friend. Install the express card on their machine and from the O2 broadband application and select "Tools->Choose Network Type->3G Only". This setting directly updates the card so even when you switch back to a using it on a Linux box it will go with 3G only. If I don't do this I've found that it will flip flop between Edge (GPRS) and 3G networks and drive you mad in the process. I found it pretty much impossible to even check my email on Edge.

Special thanks to Andy and Paul on the [ILUG](http://www.linux.ie) mailing lists for their help and also to O2, Vodaphone, Three et al. for providing Mobile Internet via hardware that can actually be used on an Open Source platform such as Linux; as we hopefully move from an era of proprietary lock-in and DRM-based crippleware to software that delivers genuine value for businesses and users.  Vodafone have gone as far as having their own Open Source website to help along development at [Betavine.](http://www.vodafonebetavine.net/web/guest/projects/open_source) Enjoy!

The revolution will not be televised! It will be streamed over TCP/IP...
