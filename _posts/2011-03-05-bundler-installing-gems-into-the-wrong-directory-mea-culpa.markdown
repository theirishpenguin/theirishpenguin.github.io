---
comments: true
date: 2011-03-05 22:44:15
layout: post
slug: bundler-installing-gems-into-the-wrong-directory-mea-culpa
title: Bundler installing gems into the wrong directory - mea culpa
wordpress_id: 1033
tags:
- Programming
- RubyIreland
- Rubyonrails
- bundler
- configuration
- gem
- install
- rails
- ruby
---

So I spent an hour and a half last night unfairly swearing at the spork gem; and blaming it for everything from world hunger to banking crises! This is because somehow when installing spork I had managed to change the location that bundler installs gems into - strangely enough into a directory called ./spork under my project directory. And I figured the blame landed at the door of the spork gem. Here's what happened just so that you don't get caught out.

Once installed, here's how you start up spork: bundle exec spork

But, at some point, here's what I did by accident: bundle **install** spork

Fool! Fool! Fool! For those of you that aren't familiar with the 'path' argument to bundler, well, what it does is permanently change your path to the value you specify. So for an hour and a half last night, I had ./spork set as my gem directory. Meaning that my furious efforts to correct the problem were in vain - such as clearing out all the gems and reinstalling, grepping for a config file that could be pointing at ./spork in my project and rvm directories.

What I should have done to fix this problem immediately, was to tell bundler to use my standard rvm directory for gems again

`bundle install --system`

Ta da!

It's pretty confusing that specifying a path argument _once off_ should cause bundler to change it behaviour on a **permanent** basis but at least I notice that in the docs it says

`The path argument to 'bundle install' is deprecated. It will be removed in version 1.1. Please use 'bundle install --path spork' instead.`

So I guess I'm not the only one who's hit this confusing behaviour. Long live the `--path` option!

Sorry spork, I'm a dork...
