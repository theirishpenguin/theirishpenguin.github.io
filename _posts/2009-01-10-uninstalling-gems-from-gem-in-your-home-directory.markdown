---
comments: true
date: 2009-01-10 12:40:02
layout: post
slug: uninstalling-gems-from-gem-in-your-home-directory
title: Uninstalling Gems from ~/.gem in your Home Directory
wordpress_id: 134
tags:
- RubyIreland
- Rubyonrails
---

`"It's installed Gem but not as we know it"`
-- Bones, if he was a Ruby Developer --

Unfortunately, a careless keystroke can leave gems in lots of unusual places. About five minutes ago, that fate befell me as I ended up with gems under my home directory at ~/.gems. Not what I was expecting. To make matters worse when I tried to remove them I had no success - possibly there were PATH or GEM_PATH issues

Fortunately, Google was to the rescue before you could say 'gem is no apt-get', with the command...

    
    gem uninstall ruby-debug-ide --install-dir $HOME/.gem/ruby/1.8


... where in this case ruby-debug-ide is the misplaced gem in question.

Thanks to [this thread ](http://rubyforge.org/tracker/index.php?func=detail&aid=22466&group_id=126&atid=575)for the solution.
