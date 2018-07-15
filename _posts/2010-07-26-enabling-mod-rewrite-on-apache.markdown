---
comments: true
date: 2010-07-26 02:44:21
layout: post
slug: enabling-mod-rewrite-on-apache
title: Enabling mod rewrite on Apache
wordpress_id: 848
tags:
- Programming
- UbuntuIreland
- apache
- Linux
- module
---

To see if mod rewrite is enabled just create a simple php page with the following content

    <?php
    echo phpinfo();
    ?>

When you browse to this page you should see mod_rewrite listed as a loaded module.

If not, then you gotta enable mod_rewrite for Apache

    sudo a2enmod rewrite
    sudo /etc/init.d/apache2 restart

Now you can create a .htaccess file into the root of your site and start adding rewrite rules. Here's a simple example to make sure rewrites are working

    RewriteEngine On
    RewriteRule (.*) http://www.google.com/

When you browse to your site, you should now be redirected to Google - if not, don't fret! There's one other gotcha you should know about! Look in the configuration file for your site under Apache (eg. `/etc/apache2/sites-available/default`) and you will see a element for your site (careful, there could be a few different elements floating around, be sure to pick the right one). This will have an `AllowOverride` attribute which is likely set to None. This is the problem - if you want rewrite rules to take effect then `AllowOverride` should not be set to None. Try changing it to All. And hey presto, you should be good to go!

This [thread](http://ubuntuforums.org/showthread.php?t=255556) on Ubuntu's forums proved invaluable in explaining this.
