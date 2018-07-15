---
comments: true
date: 2009-09-28 01:23:41
layout: post
slug: getting-drupal-7-development-snapshot-running-on-ubuntu
title: Getting Drupal 7 (development snapshot) running on Ubuntu
wordpress_id: 301
tags:
- Linux
- Ubuntu
- UbuntuIreland
---

##### Notes before starting
* At time of writing, only experimental snapshots of Drupal were available with the actual Drupal 7 release being some way off. The Drupal 5.x or Drupal 6.x series is recommended if you want to use Drupal in production
	
* This guide was written against Ubuntu 8.04
	
* This guide assumes
	
  * You have apache, mysql and php happily installed on your machine
	
  * That you are serving websites out of /var/www/
	
  * That that sites under /var/www/ are accessible in your browser via http://localhost/

## Instructions
	
* Download Drupal 7 from the development release section at and http://drupal.org/project/drupal
	
* Extract the folder and rename the extracted folder to drupal7
	
* Move the folder to an appropriate place on your webserver, such as under /var/www/
	
* Create a fresh settings file for your new Drupal 7 site. You should use the supplied settings file as a basis, eg.
	
      cp sites/default/default.settings.php sites/default/settings.php
	
* Make the settings file writeable, so that the installer can edit it, using
	
      chmod a+w sites/default/settings.php

* Create a database for your Drupal 7 site
	
  * Log into mysql, eg.
	
        mysql -uroot -p
	
  * Create a database once logged into mysql from the 'mysql>' prompt, eg.

        create database drupal7;
	
  * Create a user for the database and grant permissions from the 'mysql>' prompt, eg.
	
        GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, INDEX, ALTER, LOCK TABLES, CREATE TEMPORARY TABLES ON drupal7.* TO 'drupal7user'@'localhost' IDENTIFIED BY 'drupal7password';
	
* Run the install script as follows
	
  * Browse to your new Drupal site at http://localhost/drupal7/install.php
	
  * Elect to proceed with a normal Drupal install (ie. not minimal) in your chosen language
	
  * As you proceed through the wizard, the installer may encounter issues creating certain directories for Drupal on the file system. If so, ensure then do the following
	
    cd to the root of your drupal7 directory
	
        mkdir sites/default/files
        mkdir -p sites/default/private/files
        mkdir sites/default/private/temp
	
    Change the ownership of the created directories to belong to user account under which the web server runs under (www-data)
	
        chown -R www-data:www-data private
        chown -R www-data:www-data files
	
  * The wizard now asks you to configure the database settings. In the form presented by the wizard, replace the user 'admin' with the 'drupal7user' you created earlier and point at the drupal7 database. Remember to put in the correct password for 'drupal7user'
	
  * If you get a 500 error in the last step, then ignore it and elect to continue through to the error page. This will actually let you continue the install
	
  * If you get the error starting with something like "Fatal error: Allowed memory size of 16777216 bytes exhausted" then allocate Drupal more memory in the settings file (see See http://drupal.org/node/90605 for more information), eg. Add the line
	
        ini_set('memory_limit', '30M');

Hopefully now you should be good to go!
