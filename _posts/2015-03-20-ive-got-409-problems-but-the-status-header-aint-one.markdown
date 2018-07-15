---
comments: true
date: 2015-03-20 10:50:16
layout: post
slug: ive-got-409-problems-but-the-status-header-aint-one
title: I've Got 409 Problems but the Status Header Ain't One
wordpress_id: 1051
image: /assets/images/409image.png
tags:
- gem
- ruby
- javascript
- rails
---

A correction...  During last night's talk on the [JS Application Reloader gem](https://github.com/theirishpenguin/js_application_reloader), I mentioned that when the gem's back end code detects a reload of the application is required it sends a HTTP 409 to the client. But to use the [Chewbacca defence](https://www.youtube.com/watch?v=xwdba9C2G14), "That does not make sense!" A 409 indicates a conflict.

<figure style="float: right; margin:20px;"><img src="/assets/images/409image.png" alt="409 Image" /></figure>

Rather, the gem never sent back a 409 and never will. Instead, it returns a HTTP header to indicate an expired status (by default this header is called "X-Js-Application-Reloader-Status"). It is this that indicates to the client that the application needs to be reloaded. Incidentally, the gem does allow you to configure a HTTP status code to send back in this situation if you want to (currently the default is 200, which should probably be changed).

So where did the pesky 409 come from? Well, it became ingrained in my brain as I'm working on another project to handle optimistic locking - which does indeed send back a 409 when a conflict in records is detected. Nothing to do with JS Application Reloader at all :-) It's like comparing Apples and Androids.

For now, I'm making 409 my new lucky number!

Great meetup last night. Thanks to everyone for making it such fun!
