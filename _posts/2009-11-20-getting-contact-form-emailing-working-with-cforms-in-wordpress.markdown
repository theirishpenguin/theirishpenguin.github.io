---
comments: true
date: 2009-11-20 11:59:57
layout: post
slug: getting-contact-form-emailing-working-with-cforms-in-wordpress
title: Getting Contact Form Emailing working with CForms in Wordpress
wordpress_id: 368
tags:
- Programming
- cforms
- contact form
- emailing
- php
- wordpress
---

"Oh thou horrid little hard-coded piece of Javascript." That's our take on the jumping through hoops required to get this little plugin emailing this week. Here's why...

On uploading the wordpress site from a development machine (which had the cforms plugin installed locally) to a server online, we could not get a contact form created with CForms to send out an email. Instead, it would say "One moment please" but alas that moment would never end. We tried TLS settings and permission changes but nothing worked. Fortunately there was a solution which we came across at the plugin's somewhat squashed [forum](http://www.deliciousdays.com/cforms-forum/troubleshooting/cforms-hangs-after-submit-one-moment-please/).

When we had developed the site locally, the plugin had hardcoded a variable 'sajax_uri' into the /wp-content/plugins/cforms/js/cforms.js. This is what was causing the pesky problemo and a quick edit of that file to point the variable at a correct URL for our server fixed the issue.

Hmm... I'm sure there's a good reason is not a variable in a config somewhere. There's a few hours of my evening I'll never get back...
