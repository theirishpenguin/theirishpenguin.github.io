---
comments: true
date: 2010-07-25 05:41:01
layout: post
slug: simply-adding-a-linux-partition-via-fstab
title: Simply adding a Linux Partition via fstab
wordpress_id: 831
tags:
- fstab
- Linux
- mount
- partition
---

Just add something like the following to /etc/fstab...

    UUID=1208c5dc-d4a6-a7a2-8352-ab12ecd64412 /media/disk-1  ext4    relatime,errors=remount-ro 0 2

... where

* UUID uniquely identifies the partition you wish to add (you can get the UUID for you drive using `ls -l /dev/disk/by-uuid`)


* /media/disk-1/ can be changed to be location on your system - it's where the partition will be added


* I don't really have a monkeys of what the other settings do, but I think they are more or less the usual defaults. Works for me!

Bang! Short blog post! Goodnight!