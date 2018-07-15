---
comments: true
date: 2009-01-16 08:25:08
layout: post
slug: hackin-on-gruff-a-brief-overview-of-gem-development-with-ruby
title: Hackin on Gruff - A Brief Overview of Gem Development with Ruby
wordpress_id: 179
tags:
- Geek
- Programming
- RubyIreland
- Rubyonrails
---

Ah such is the life. Chillin' in Havana (the bar, unfortunately not the city), hackin' away on Gruff of all things. This is the my first attempt at development on a gem and it has to be said is surprisingly satisfying. Getting gems to build is a doddle. Here's a great [link](http://www.5dollarwhitebox.org/drupal/creating_a_rubygem_package) that shows how it's done in moments. Also a handy thing to know is how to suck the code out of your OS's gems directory and unpack them to under your app's vendor/gems directory - all courtesy of [VendorEverything](http://errtheblog.com/posts/50-vendor-everything). You can create the vendor/gems directory manually if it doesn't already exist.

When developing on the gem, I found that the best strategy was to clone down the gem source code from GitHub or Rubyforge to under the vendor/gems directory of my application rather than using the OS package unpacking technique of Vendor Everything (though they do it more for deployment than development - which is a great idea). That way I could easily stay on top of the latest source code using git. Actually, to make things even cleaner I downloaded the Gruff gem source code to a different directory totally unrelated to my sample project and then symlinked to it from under vendor/gems of my app. Clean as an (unused) whistle!

And with Gem, Git and GitHub behind me life was trouble free. Now back to my search for great Cuban cigars...
