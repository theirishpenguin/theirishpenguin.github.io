---
comments: true
date: 2016-10-09 20:26:12
layout: post
slug: fixing-a--virtualbox-4-to-5-upgrade-by-reinstalling-guest-host-additions
title: Fixing a VirtualBox 4 to 5 Upgrade by Reinstalling Guest Host Additions
wordpress_id: 1053
highlight: false
image: https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Virtualbox_Faenza.svg/500px-Virtualbox_Faenza.svg.png
tags:
- VirtualBox
---

This upgrade did not go quite as smoothly as expected but after a bit of shouting at
the computer we got there. The issues may have been specific to the
state of my virtual machine image and possibly won't affect other people
upgrading. Anyway in my case, after I upgraded to VirtualBox 5 and began
to use my image with it, I realized Copy & Paste between the host and the
guest would not work.

<figure class="responsive-post-figure">

<a title="By Matthieu James
(https://code.google.com/p/faenza-icon-theme/) [GPL
(http://www.gnu.org/licenses/gpl.html)], via Wikimedia Commons"
href="https://commons.wikimedia.org/wiki/File%3AVirtualbox_Faenza.svg"><img class="responsive-post-figure__image"
width="291" class="responsive-post-figure__image" alt="Virtualbox Faenza"
src="https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Virtualbox_Faenza.svg/480px-Virtualbox_Faenza.svg.png"/></a>

</figure>

Additionally Shared folders between the host and guest would not work.
This left me with no option to communicate a piece of text between the
host and guest, so rather than limping on like a dying goldfish I was
forced to confront the problem head on.

<b>Turns out I needed to uninstall and reinstall the Guest Host Additions (GHA).</b> As
mentioned before this may be a problem specific to my image. It might
have only become a problem when I did a software update on the guest OS
(Ubuntu 14.04). The takeaway point is if Copy and Paste stops
working, check to see if your Guest Host Additions are borked.

I had to reinstall the GHA according to the non-open source VirtualBox
instructions.

I found the solution to performing a correct GHA reinstall at this
[link](https://forums.virtualbox.org/viewtopic.php?f=7&t=46626#p210465).
Here is a summary below.

##### Uninstall GHA as follows
<i><b>NB:</b> Don't unmount the existing GHA iso from the Optical
Storage media (if you do you can re-add it at the correct location on the
host - eg. /usr/share/virtualbox/VBoxGuestAdditions.iso)</i>

With that in mind here is how you can perform an uninstall. Run the
following within the <b>guest</b> OS.

    cd /opt/VBoxGuestAdditions-X.Y.Z (where X.Y.Z is the old version of VirtualBox)
    sudo ./uninstall.sh

##### Reinstall GHA as follows
Ensure you don't have any Ubuntu based guest host additions
installed. The command "aptitude search VirtualBox|grep add" should
return no installed packages.

Now you are ready to do the reinstall. Run the following within the
<b>guest</b> OS.

    cd /media/yourusername
    cd VBOXADDITIONS_X.Y.Z_BUILD
    # ... where X.Y.Z is the NEW version of VirtualBox and BUILD is presumably a build number
    sudo sh ./VBoxLinuxAdditions.run

Now your GHA should be correctly reinstalled and things like Copy &
Paste as well as Shared folders should work again!

<i>Title Image Attribution: By Matthieu James (https://code.google.com/p/faenza-icon-theme/) [GPL (http://www.gnu.org/licenses/gpl.html)], via Wikimedia Commons</i>
