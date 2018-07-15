---
comments: true
date: 2009-11-12 01:08:37
layout: post
slug: offline-documentation-for-rails-and-other-ruby-gems
title: Offline Documentation for Rails (and other Ruby gems)
wordpress_id: 350
tags:
- documentation
- gem
- offline
- rails
- ruby
---

I used to pretty much always install gems with the --no-ri --no-rdoc options to speed up installation. Recently however, I've found myself needing to get access to documentation whilst on the move. So just in case you don't know how that works, here's the deal.

* Install your gems as per normal (ie. don't use --no-ri or --no-rdoc)
* Run the command 'gem server' from the command line
* Browse to http://localhost:8808
* And voila! You should have all the docs you need available by clicking on the rdoc link for any given gem
* But if you really want to get fancy check out the searchable Rails documentation at http://railsapi.com - there's an online version as well as the downloadable (the links are at the top of the page and can easily be mistaken for an advert!)
