---
comments: true
date: 2007-12-09 10:13:16
layout: post
slug: uninitialized-constant-gemrunner-error-when-using-ruby-gem
title: Uninitialized Constant GemRunner Error When Using Ruby Gem
wordpress_id: 64
tags:
- Linux
- Programming
- RubyIreland
- Rubyonrails
- Ubuntu
---

Here's the problem...

me@host:~$ sudo gem update
/usr/bin/gem:23: uninitialized constant Gem::GemRunner (NameError)

... which had us on the ropes more than on the rails for a while. Unusually googl'ing on this error provided no solutions.

What led to the situation was that we used the source install of rubygems on Ubuntu Gutsy (7.10) instead of using the rubygems in Ubuntu's repository but then changed our mind and apt-getted the Ubuntu repository version. Surprise! Surprise! These 2 versions were conflicting a bit; leading to the above error. The workaround is pretty simple, just go to your /usr/local/lib section and delete the site_ruby directory (as this is the remnant of the rubygems source install and thus cause of the problem). This removes all the gems (that were downloaded by the original rubygems which we no longer want) off our system. Perhaps you want to simply move this directory first in case something goes wrong and you need to revert (eg. sudo mv /usr/local/lib/site_ruby /usr_local/lib/site_ruby_old).

Note: In case your not aware, /usr/local/* is the set of directories under which programs that you compile yourself get installed to by default. Generally the directories will start out pretty empty on a freshly installed Linux distro and then as you (if ever!) compile and install programs from source (eg. using ./configure && make && make install) then they end up under this directory. Also not that programs installed using apt-get (or via rpms on non-Debian systems) don't get put here - they usually end up under the /usr/ directory itself (this varies a bit from distro to distro but what we've just outlined holds true for Ubuntu anyway).

Now, once your finished you should find that gem works. Do a 'gem list' and see if the above error is gone. If this doesn't work you may need to 'sudo apt-get install rubygems'. Next up, we need to rebuild that gem directory that we deleted (site_ruby) with the apt-gotten rubygems (if apt-gotten is a real word!). To do this run

'sudo gem update'
'sudo gem update --system'

You will notice that the result of these commands means that /usr/local/lib/site_ruby is back and populated. This is where ruby likes to put it's gem extensions. Finally reinstall rails with

'sudo gem install rails'

Hope this solution works for you! We're still getting to grips with this rails stuff so if you find any glaring errors in this post please comment below to let us know.



