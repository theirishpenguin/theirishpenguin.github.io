---
comments: true
date: 2009-02-20 08:34:46
layout: post
slug: 5-apache-troubleshooting-tips-for-friday
title: 5 Apache Troubleshooting Tips for Friday
wordpress_id: 210
---

1) When you browse all your hosted sites and they're all down then there's a good chance Apache is too. Do a 'sudo /etc/init.d/apache2 restart' and pay special attention to see if the 'fail' message appears. Not sure if you get as good an indication that the server is 'ok' if you just do the more graceful 'sudo /etc/init.d/apache2 restart'

2) It goes without saying but check your log files, especially the error.log file at /var/log/apache2

3) Under /etc/apache2/sites-available/my_cool_website.com, ensure that any custom ErrorLog's or CustomLog's you have set actually exist on disk - or else apache may fail to restart

4) Restart, restart, restart! When you enable sites or modules try not to forget to restart apache. It easy to change a setting such as the server url of your site in a sites-available file and forget the all import restart. You'd think I did this before!

5) When you migrate servers don't forget to set your application or site directories to the appropriate user. This is distro specific; on Red Hat and Cent OS this is 'apache', on Ubuntu this is 'www-data'. Others could be different again.

Bonus tip: Apache comes with mod_rewrite installed but not enabled. If you need it, be sure to enable it using a 'sudo a2enmod rewrite' and ya, you guessed it, restart apache!
