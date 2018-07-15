---
comments: true
date: 2008-10-09 08:33:10
layout: post
slug: troubleshooting-fcgi-and-the-dreaded-undefined-method-require_gem-error
title: Troubleshooting fcgi and the dreaded undefined method `require_gem' error
wordpress_id: 79
tags:
- Linux
- Programming
- RubyIreland
- Rubyonrails
---

It happens to the best of us. We've coded our app go to deploy it and encounter some dispatch.fcgi issue. Today was the turn of  

    dispatch.fcgi error: undefined method `require_gem' for main:Object (NoMethodError)




Well way to troubleshoot and arrive at a solution is to actually run ./dispatch.fcgi. I didn't know you could do this! It's well handy! If you are on a remote server to which you don't have ssh access then you can probably still run it as a cron job. Something like cd /path/to/my/app/public && ./dispatch.fcgi should do it. Remember that the dispatch.fcgi file is in the public directory of your application. The combination of running ./dispatch.fcgi and viewing the Rails log file revealed the useful error message above. Then a quick google search revealed that we need to change require_gem to simply gem (see [here](http://blog.nanorails.com/articles/2007/12/20/ruby-gem-1-0-is-out)).




I had to change this in the dispatch.fcgi and then grepped the whole application directory for any instances of require_gem and changed them to gem too.



