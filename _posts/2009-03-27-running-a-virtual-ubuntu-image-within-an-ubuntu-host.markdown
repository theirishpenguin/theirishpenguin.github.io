---
comments: true
date: 2009-03-27 10:33:18
layout: post
slug: running-a-virtual-ubuntu-image-within-an-ubuntu-host
title: VirtualBox and Running a Virtual Ubuntu Image within an Ubuntu Host
wordpress_id: 227
tags:
- Linux
- Programming
- RubyIreland
- Ubuntu
- UbuntuIreland
---

"What?" you say, "that's a lot of Ubuntu going on! Why would you want to do such a thing?" The answer - for testing applications, replicating environments or perhaps running a few servers on one box.

This guide should work pretty well for any Linux distro, though you may need to replace the aptitude commands with the package manager of your choice. Here we'll install a Hardy Heron guest inside an Intrepid Ibex host. Afterwards, we'll also use dselect with apt in order to clone the packages on a machine we wish to replicate onto our guest OS. Oh ho the fun! Here goes...

We'll start from scratch on your developer (host) machine with no prerequisites. Here are the steps

* Install the VirtualBox program

      sudo aptitude install virtualbox

* Install 7zip, needed to extract downloaded image

      sudo aptitude install p7zip

* Download Ubuntu 8.04 Hardy Heron iso image from `http://virtualbox.wordpress.com/images/ubuntu/`

* Make a new folder called my_temp

      Move the downloaded file into my_temp
      cd into my_temp

* Extract image

      p7zip -d downloaded_imagefile

  This should yield a folder called something like ubuntu-8.04-x86
  cd into this directory and run

      mv VDI/ubuntu-8.04-x86 ~/.VirtualBox/VDI

* Create a new virtual machine

  * Run VirtualBox (should be in Accessories under the Applications menu or just type 'virtualbox' at the command line)
  * Click the New button to create a new virtual machine
  * Create a name for your Virtual Machine and set it's OS Type
  * Set the base memory to 256MB
  * Elect to add an 'Existing Hard Disk', you the Add button and choose the ubuntu-8.04-x86.vdi under the ~/.VirtualBox/VDI directory

* Run and customise new virtual machine

  * You should now have a new Virtual Ubuntu machine at your disposal. Start it up by clicking the Start button.
  * Log in with ubuntu/reverse as username password. Double check that this is correct by looking at the site you downloaded the image from
  * Once logged in change the password through the System/Administration/Users and Groups menu
  * Install 'Guest Host Additions' from the Devices menu of the running window of you virtual machine. GHA allow you to copy and paste between the host and guest OS's, along with a raft of other improvements. Tip: If your mouse gets stuck in the virtual machine window then use the right control key to let it escape.

    If the GHA install does not work (due to a timeout) then you will need to install the Guest Host Additions manually, as follows

    1. On your real Ubuntu machine (ie. the host) download the file that was specified as a URL in the popup that was displayed when you previously tried to install Guest Host Additions - if you forget the URL try to download the GHA again from the Devices menu and when the URL appears copy and paste it into FireFox running on your host machine. Note: The GHA are installed onto your host machine.

    1. Once downloaded, move the file to /usr/share/virtualbox on your host machine and create the following symlink (as virtualbox won't recognise the file if it has the revision number in the filename)

           sudo ln -s /usr/share/virtualbox/VBoxGuestAdditions_2.0.4.iso /usr/share/virtualbox/VBoxGuestAdditions.iso

    1. Once again try to install 'Guest Host Additions' from the Devices menu of the running window of you virtual machine. This time it will pick up the local file you downloaded.

* Create a shared folder - to swap files between your host and your VM
  * On your host machine create a directory you will use for sharing
  * On your running virtual machine create a directory you will use for sharing
  * From the Devices menu of the running VirtualBox windows select Shared Folders and set the 'folder path' to the folder you just created on your host. Give it a friendly name in the 'folder name' field and elect to make it permanent. Then on your VM run
  `mount -t vboxsf the_friendly_name /path/to/folder/on/virtual/machine`

Note: That vboxsf is the filesystem type that VirtualBox is using for shared folders

Now you should be ready to go with your VM. Congratulations!

As a final step you may want to take this vanilla Ubuntu machine update it so that it has the same packages as another machine, in the case where you are looking to replicate an environment. Use dselect and apt to do this as laid out in the following guide [Restore Packages using dselect](http://kevin.vanzonneveld.net/techblog/article/restore_packages_using_dselectupgrade) on Kevin von Zonneveld's blog.

As a final step you may want to install any other software that is not covered by aptitude packages - such as programs for which no debian package exists or for things like Ruby on Rails gems. It shouldn't take you long to put these on your new virtual machine and "hey presto!" you're ready to rock!
