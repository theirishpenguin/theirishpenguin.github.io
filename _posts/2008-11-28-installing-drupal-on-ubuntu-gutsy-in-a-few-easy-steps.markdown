---
comments: true
date: 2008-11-28 03:54:51
layout: post
slug: installing-drupal-on-ubuntu-gutsy-in-a-few-easy-steps
title: Installing Drupal on Ubuntu (Gutsy) in a few easy steps
wordpress_id: 80
tags:
- Linux
- Ubuntu
- UbuntuIreland
---

Drupal is a great solution if you're looking for a CMS system. In order to sneakily install LAMP with the minimum of fuss, I usually just install mod php and mod mysql (the apache related modules for php and mysql respectively) and that triggers pretty much everything else to be pulled automatically! So, from the command line...


    sudo aptitude install libapache2-mod-php5
    sudo aptitude install php5-mysql


... should give you Apache, MySQL and PHP in one fell swoop. Just to be sure that all is well run the following install commands


    sudo apt-get install mysql-server
    sudo apt-get install apache2
    sudo apt-get install php5
    sudo apt-get install php5-mysql


Then download and install Drupal (version 6.6 at time of writing) at http://drupal.org and follow their install guide.

One final tip, if there's any problem with your apache installation's configuration, you can install phpMyAdmin in order to plough through these problems as it will supply its own configuration. For example, I got the database configuration error when I was trying to connect to my database for the first time using Drupal

"Your web server does not appear to support any common database types. Check with your hosting provider to see if they offer any databases that Drupal supports."

Turns out my apache config was dodge as when I did a `sudo apache2ctl restart` I got the following...

"apache2: Could not reliably determine the server's fully qualified domain name, using 127.0.1.1 for ServerName"

Installing phpMyAdmin and choosing apache2 when prompted during this process did the trick. Now go forth and Drupal!
