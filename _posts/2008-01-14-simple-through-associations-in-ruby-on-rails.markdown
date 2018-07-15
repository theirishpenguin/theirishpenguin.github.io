---
comments: true
date: 2008-01-14 14:12:21
layout: post
slug: simple-through-associations-in-ruby-on-rails
title: Simple 'Through Associations' in Ruby on Rails
wordpress_id: 68
tags:
- Linux
- Programming
- RubyIreland
- Rubyonrails
---

This little article shows one way to model many-to-many relationships using a join table.

Obviously, The Penguin isn't the first so [here](http://wiki.rubyonrails.org/rails/pages/Beginner+Howto+on+has_many+%3Athrough) is an alternative good practical example which might give your good self an different perspective. Also [this documentation](http://wiki.rubyonrails.org/rails/pages/ThroughAssociations) has some more detailed information but doesn't have a simple self contained example like below (and neglects to mention belongs_to in its primary example - at time of writing this).

Here goes. The following statements define our basic requirements.

* An order has many items
* An item has many orders
* We shall model this through a join table called order_items

    
      orders     order_items    items
      -----      ----------     ----
       id         order_id        id
                  item_id


Before we continue, please note that a massive massive thing to remember is that Order needs to have a has_many to the join table model AS WELL as a has_many (through the join table model) to Item. Also the join table model has a belongs_to for each model.

      class Order < ActiveRecord::Base
            has_many :order_lines #Don't forget this line!
            has_many :items, :through => :order_lines
      end
      
      class Item < ActiveRecord::Base
            has_many :order_lines  #Don't forget this line!
            has_many :orders, :through => :order_lines
      end
      
      class OrderLine < ActiveRecord::Base
            belongs_to :order
            belongs_to :item
      end

Ok so that's it folks! The Penguin has to admit that the above code hasn't been run in a RoR interpreter so if has typo's or smelly code please comment below.

One last thing is that if you're going to try and present a RoR solution in an enterprise situation it is quite likely that the powers that be will want to see foreign key relationships in your database tables (note, this applies to all db relationships; not just man-to-many). These will give referential integrity to your associations. One very very handy and straightforward way to do this is using Red Hill's foreign_key_migrations plugin. This really is great (it does pretty much all the hard work for you!) so it's worth a serious look.

One gotcha with using foreign keys in Rails, is that the order in which test fixtures load becomes important. See Per Olesen's [post](http://techpolesen.blogspot.com/2007/04/rails-fixture-tips.html) for tips on countering this. Other than that happy hacking and may the [Rails Rise to Meet You](http://en.wikipedia.org/wiki/May_the_road_rise_to_meet_you)!
