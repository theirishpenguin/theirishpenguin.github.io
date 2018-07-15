---
comments: true
date: 2011-02-16 00:56:59
layout: post
slug: machinist-2-and-the-undefined-method-foo-for-shammodule-error
title: Machinist 2 and the undefined method for Sham:Module error
wordpress_id: 1025
tags:
- Programming
- RubyIreland
- Rubyonrails
- error
- machinist
- rails
- sham
---

This ain't no Sham marriage! Machinist 2 has done away with the Sham module. But, at time of writing, this isn't immediately obvious from the [installation guide](https://github.com/notahat/machinist/wiki/Installation). So if you try to horseshoe your Machinist 1 (Sham-based) tests into Machinist 2 then you'll find you get an error like

/home/you/dev/rails/my_project/spec/support/blueprints.rb:5:in `': undefined method `name' for Sham:Module (NoMethodError)

The solution is to use the new serial_number() method technique instead. For more info on what's in Machinist 2 check out the [What's new in Machinist 2](https://github.com/notahat/machinist/wiki/machinist-2) page.

A short post but hopefully it helps someone. Mock on!
