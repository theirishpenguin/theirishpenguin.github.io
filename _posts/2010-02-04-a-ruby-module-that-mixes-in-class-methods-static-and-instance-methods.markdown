---
comments: true
date: 2010-02-04 11:08:34
layout: post
slug: a-ruby-module-that-mixes-in-class-methods-static-and-instance-methods
title: A Ruby Module that mixes in Class Methods (static) and Instance Methods
wordpress_id: 445
tags:
- Programming
- RubyIreland
- Rubyonrails
- static class methods
- include
- extend
- module
- mixin
- ruby
- rails
- singleton
---

Ho ho, this one can catch you out more than once so it's high time to write a blog post to cover this off. Turns out it's a commonly used pattern to the rescue. Thanks to eoin on #ruby.ie for pointing to the solution on [RailsTips.org](http://railstips.org/blog/archives/2009/05/15/include-vs-extend-in-ruby/).

Here's quite a tasty diagram too for [easy reference](http://smartbomb.com.au/2009/02/an-idiom).


    
    
    module Swingable
    
        def self.included(base)
            base.extend(ClassMethods)
        end
    
    
        def instance_swing
            puts 'Did an instance swing!'
        end
    
        module ClassMethods
            def static_swing
                puts 'Did a static swing!'
            end
        end
    end
    
    class BaseballBat
       include Swingable
    end
    
    BaseballBat.static_swing
    BaseballBat.new.instance_swing
    
