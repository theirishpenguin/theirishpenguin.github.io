---
comments: true
date: 2009-07-22 08:43:49
layout: post
slug: howto-add-a-secondary-hard-drive-for-windows-via-virtualbox-2-1-4-ose
title: 'HOWTO: Add a secondary hard drive for Windows via VirtualBox 2.1.4 OSE'
wordpress_id: 247
tags:
- Linux
- VirtualBox
---

Sometimes one disk just isn't enough. In fact most times! Here's how to add an E Drive to your Windows Guest OS
	
* In VirtualBox, go to the File->Virtual Media Manager

* Click the New button to create a new hard disk and create a new hard drive file via the wizard (a .vdi file)

* Ensure Windows Guest OS has been shut down

* Click on the Settings button for your Windows Guest OS, and choose the Hard Disks tab

* Add the .vdi file you just created to be a hard drive for the Guest OS by clicking the Add Attachmenticon on the right and selecting your .vdi file in the file explorer from the drop down list that appears, here is the typical order of drives on a system

  * IDE Primary Master: this is the main drive onto which your Guest OS is installed (very important!)

  * IDE Primary Slave: this is the first additional drive you add on (ie. the E: drive)
	
  * IDE Secondary Slave: this is the second additional drive you add on
	
* Once your done start up you Virtual Machine Guest OS

* Visit the Control Panel in Windows
	
* If you're using XP elect to 'switch to classic view' on the left of Windows Explorer
	
* Visit Administrative Tools->Computer Management
	
* Under the storage node on the left, there should be a Disk Management node
	
* A wizard should instantly popup to help you add the drive as soon as you click on this, agree to its demands
	
* After the wizard, you should see a drive displayed as 'unallocated' as you scroll down the list of drives

* Right click, select New Volume and before you know it you should be done!

* Now go and open Windows Explorer and experience the joy that is an extra drive!


