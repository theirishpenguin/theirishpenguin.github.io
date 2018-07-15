---
comments: true
date: 2009-09-19 09:00:45
layout: post
slug: audacity-tip-of-the-day-how-not-to-lose-data
title: Audacity Tip of the Day - How Not to Lose Data!
wordpress_id: 283
---

One issue when editing audio, is copy and pasting a section of a track from one open Audacity project to another. To save space audacity does not copy the underlying track completely to the new project, rather it links to it. This means that your second project (the one you are pasting into) is not completely self-contained as it depends on external files. This can be a quickfire way for the unsuspecting podcaster to lose a whole bunch of data (yes, me!). This problem is particularly nasty as you don't realise something has gone wrong until you close and reopen the project - finding that a long stretch of audio containing your beautiful voice is missing. To avoid this, adhere to the following workflow when copy and pasting from one project to another.

* In the first project, select and copy the audio you wish to duplicate
* Paste the audio into the second project
* In the File menu of the second project, click 'Check Dependencies'
* Click 'Copy All Audio into Project (Safer)'
* Just to stress the previous point, you really do want to use the **Safer** of the two copying options. I've found that using the other option results in some of the audio I wanted to copy being truncated
* Save the project

By following this workflow you should hopefully avoid seeing what I call the 'dreaded blue flat-line of death' where, on reopening of a project, you find that the middle of a track has been lost. If you adhere to these instructions you should also be able to select 'Delete orphaned files' when it appears from time to time while reopening an Audacity project. However, due to the frustrating and sensitive nature of audio loss issues, I accept no responsibility for anything that goes wrong! Best of luck and happy editing!
