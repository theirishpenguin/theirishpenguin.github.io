---
comments: true
date: 2009-03-04 08:45:10
layout: post
slug: phusion-passenger-configuration-file-location-passengerconf
title: Phusion Passenger Configuration File Location - passenger.conf
wordpress_id: 215
tags:
- Linux
- Programming
- Rubyonrails
- Ubuntu
---

This was not easy for me to find! My beloved Ruby on Rails apps just sitting there untweaked! Google and even the Passenger website didn't specify where the config file may be found. And eventually it made a startling difference to my apps performance - possibly given that I'm trying to host a few sites at once - so it would be nice if it was easier to learn about how to setup the config file when new to Passenger,

Out of the box on a vanilla passenger install there is no passenger configuration file. However, there are a lots of [configuration options](http://www.modrails.com/documentation/Users%20guide.html#_configuring_phusion_passenger) and you can either dump these into

a) /etc/apache2/apache2.conf file (messy) or
b) Create a new file called passenger.conf under the /etc/apache2/conf.d directory as files in thei directory automatically get loaded by apache
c) Create a passenger.load file in mods-available and then enable the module

By the way, this setup is on Ubuntu, your mileage may vary depending on your distro. For an example passenger.conf file see this one (link no longer available), just be sure to get the 'LoadModule passenger_module', 'PassengerRoot' and 'PassengerRuby' settings correct. You may already have these specified correctly in your apache2.conf file if you already have passenger working; if so you can reuse these values.

Apparently the recommended PassengerMaxPoolSize is 2 if you're on a 256 MB Virtual Private Server System that's running things like MySQL and keep the PassengerMaxInstancesPerApp smaller than this. If you're running a couple of rails sites then maybe set PassengerMaxInstancesPerApp to 1 if you want to have 1 instance always available for each site. A RailsSpawnMethod of 'smart' can also lead to better performance depending on your setup.

Certainly playing around with this config file helped me greatly improve my sites' responsiveness for little effort and in particular it got the usage of the all important swap space down.

One final tip for today is to install htop (is available through aptitude). This gives a very useful and pretty display of the 'top' commands information and can make monitoring things like memory and swap at a glance much easier. So armed with this knowledge go forth and spawn! Well, till you run out of memory at least!
