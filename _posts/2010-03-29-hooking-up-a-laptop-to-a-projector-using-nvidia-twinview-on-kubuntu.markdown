---
comments: true
date: 2010-03-29 07:33:50
layout: post
slug: hooking-up-a-laptop-to-a-projector-using-nvidia-twinview-on-kubuntu
title: Hooking up a laptop to a projector using Nvidia Twinview on Kubuntu
wordpress_id: 463
tags:
- nvidia
- kubuntu
- settings
- projector
- tv
- display
---

##### UPDATE 1
As far as it can be confusing as to whether Nvidia Twinview is changing the underlying resolution of your display. Here's some tips that may help

* Adjust the resolution ***before*** you hook up your laptop to a projector

* If you adjust the resolution and it doesn't look like what you would expect (eg. the bottom half your display is missing) then logging out and back in may help

##### UPDATE 2

I found that adjusting the display settings using a tool other than Twinview helped (in KDE on OpenSuse 11.2 I found that searching for sax2, a part of YaST, let me change my screen resolution without problems - once I dropped the screen resolution to be the same as the resolution of the projector then I didn't need to mess around with Twinview at all).

Here is the rest of the original article...

The number of configuration options can be a bit daunting when you haven't used Nvidia Twinview before. Here's a quick simple recipe

* Set both the laptop screen to be the same as the maximum supported resolution of the projector (you can use the 'Model' dropdown list to choose between settings for the laptop and the projector). If you set the of the project to Auto and click apply the diagram should tell you the max supported resolution for the projector
* Ensure position is set to Absolute for both the laptop and the projector
* You can drag the actual boxes representing each screen in the diagram but the best thing to do is ensure they overlap as much as possible
* Finally click Apply and you should get a pretty good match. You may still need to resize the window you want to show in order to get the projector fully displaying it
