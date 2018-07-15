---
comments: true
date: 2010-11-22 11:47:53
layout: post
slug: getting-pyzeemote-running-on-meego
title: Getting Pyzeemote running on MeeGo
wordpress_id: 1006
tags:
- bluetooth
- driver
- meego
- python
---

Pyzeemote allows a Zeemote controller to communicate with a running application over D-Bus. We're going to get it running on MeeGo today. All in all, getting this working will involve the following components

* Python drivers for the Zeemote device (provided by Pyzeemote)
* A daemon which listens for Pyzeemote events and shepherds them onto the application over D-Bus (provided by Pyzeemote)
* A test suite which tells you if everything is working correctly (provided by Pyzeemote)
* Bluetooth python bindings (provided by 3rd party library PyBluez)

### PRE-REQUISITES

The MeeGo machine these steps were carried out on was a Leveno IdeaPad, which had the MeeGo core repository disabled and the MeeGo test and devel repos enabled - as outlined at our earlier guide [Installing Ruby and Rubygems on MeeGo](http://www.theirishpenguin.com/2010/11/18/installing-ruby-and-rubygems-on-meego). You may need to do this as well, as these repositories are likely the source of some of the libraries used in this guide. Furthermore you will need to install packages for building python bluezy bindings
    
    sudo zypper install gcc make python-devel bluez-libs-devel

### PYZEEMOTE INSTALLATION STEPS

1. Create a directory pyzee in your home directory
    
      mkdir pyzee

1. Download [pyzeemote source on Google Code](http://code.google.com/p/pyzeemote) using svn
1. If you don't have svn you can just use the Browse functionality of Google Code and download (the raw version) of the following files manually:
  
      pyzeemote-test.py, zeemote_listener.py, README

1. Whether you use svn or Browse simply ensure that you have the above 3 files at the top level of your pyzee directory

1. Download bluezy python bindings (PyBluez-0.18.tar.gz) which will work on MeeGo from [PyBluez on Google Code](http://code.google.com/p/pybluez)
1. Move the PyBluez-0.18.tar.gz to the top level of your pyzee directory
1. Change directory to the pyzee directory
    
       cd ~/pyzee

1. Extract the PyBluez-0.18 contents

    
      tar -zxvf PyBluez-0.18.tar.gz


1. Change directory to the PyBluez-0.18 directory

    
       cd PyBluez-0.18


1. Build the python bluetooth bindings by running

       python setup.py build

1. Change directory back up one level so that you're inside the top level of the pyzee directory
 
       cd ..

1. Create a symlink to the freshly built bluetooth python bindings, so that they'll be found when we run pyzeemote
  
       ln -s PyBluez-0.18/build/lib.linux-i686-2.6/bluetooth

1. Fire up the pyzeemote daemon (you shouldn't see any output) using
    
       python zeemote_listener.py

You shouldn't see any output if things went correctly. If you get the following then there is a problem with the bluetooth python bindings built in the last steps

    ---------------------------------------------------
    Traceback (most recent call last):
    File "zeemote_listener.py", line 39, in <module>
    from bluetooth import *
    ImportError: No module named bluetooth
    ---------------------------------------------------
You'll have to figure out why this is. Perhaps the symlink wasn't created correctly or it was created in the wrong place?

1. Run the pyzeemote test suite
    
       python pyzeemote-test.py


1. You should see it say

   Trying to find a Zeemote device...

1. Try to click some buttons on your zeemote device. If successful, you should see output at the command line as you do so. Congrats, it's working!
