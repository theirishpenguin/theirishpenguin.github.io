---
comments: true
date: 2009-09-16 10:08:24
layout: post
slug: simple-straight-up-caching-for-pages-served-by-heroku
title: Simple straight up caching for pages served by Heroku
wordpress_id: 271
tags:
- Geek
- Linux
- Programming
- RubyIreland
- Rubyonrails
---

So you've got an app that's ticking along nicely; being served up a good steak in a 5 star restaurant - but you'd like to boost it's performance with some caching. For those who develop their apps on the Heroku platform, a great way to do this is to cache a dynamic page using Varnish. This means that your page is served up super fast without hitting Rails/Sinatra/whatever. And best of all it requires no extra gems or anything, just a well placed one-liner in your controller.

Firstly, you can only use this technique if all users that visit this page expect to see the exact same content - in other words you have no 'per user' customised content on a page. To help understand how this type of caching works, imagine that the first time your page (let's say an Events index page) is hit it is turned into a static html page for a pre-defined amount of time (let's say 60 seconds). Anyone else who visit this page (ie. anyone else who visits this particular controller action) during the next 60 seconds gets that static html page. After the 60 seconds the static html page is removed from the cache. Thus the next hit will cause your underlying dynamic page to be invoked; then the caching process kicks off again lasting another 60 seconds. And so on and so fourth.

With the increasing amount of web applications that call APIs, such as Twitter's API, this is a really easy way to ensure that you do not end up spamming a service provider with an unreasonable number of calls per hour. This is the technique we use on www.thelisbontweety.com (link no longer available) to keep our API overhead down.

So how do you do this? Simply put something along the lines of


    response.headers['Cache-Control'] = 'public, max-age=60'


as the first line of your action for the page you wish to cache. The max-age setting means that this will be cached for 60 seconds. After you put this in your application and redeploy to Heroku, you can see if it's working by using http://hurl.it

Just enter the  URL for your action and click Send. You should see something like "Cache-Control: max-age=60, public" in the output if it's working.

And that's it! No need to install anything. Just cache your little heart out with Varnish. Top marks to chaps at Heroku for making this so easy to use out of the box at [Heroku](http://heroku.com). For more on this technique check out their HTTP caching docs at [http://docs.heroku.com/http-caching](http://docs.heroku.com/http-caching)
