---
comments: true
date: 2009-01-22 08:58:35
layout: post
slug: bug-of-the-day-nilinclude-error-with-create_time_zone_conversion_attribute
title: 'Bug of the Day: nil.include error with create time zone conversion attribute'
wordpress_id: 196
tags:
- Geek
- Programming
- RubyIreland
- Rubyonrails
---

(Note: Old article title was 'Bug of the Day: nil.include error with create_time_zone_conversion_attribute')

This was an 'orrible bug. Tired and midway through writing up a Ruby on Rails tutorial on setting up emailing with AR Mailer and a little postfix configuration I wasn't exactly in the mood for a bizzarely cryptic issue to waste my time. Enter the mysterious create_time_zone_conversion_attribute? method in all it's glory. Basically you will get this error if you set ...

    config.cache_classes = false

... wherever it is set in your environment files (in my case config/development.rb) but the error goes away if you change it to ...

    config.cache_classes = true

... bloody daft! Here is the bug on [lighthouse](http://rails.lighthouseapp.com/projects/8994/tickets/1339-arbase-should-not-be-nuking-its-children-just-because-it-lost-interest). Arrgh!!!!

Anyway here is the full stack trace which may help someone googling to pick up this page


    NoMethodError in UsersController#create
    
    You have a nil object when you didn't expect it!
    You might have expected an instance of Array.
    The error occurred while evaluating nil.include?
    
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/attribute_methods.rb:142:in `create_time_zone_conversion_attribute?'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/attribute_methods.rb:75:in `define_attribute_methods'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/attribute_methods.rb:71:in `each'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/attribute_methods.rb:71:in `define_attribute_methods'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/attribute_methods.rb:350:in `respond_to?'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2587:in `attributes='
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2583:in `each'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2583:in `attributes='
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:2283:in `initialize'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:691:in `new'
    /usr/lib/ruby/gems/1.8/gems/activerecord-2.2.2/lib/active_record/base.rb:691:in `create'
    vendor/gems/ar_mailer-1.3.1/lib/action_mailer/ar_mailer.rb:92:in `perform_delivery_activerecord'
    vendor/gems/ar_mailer-1.3.1/lib/action_mailer/ar_mailer.rb:91:in `each'
    vendor/gems/ar_mailer-1.3.1/lib/action_mailer/ar_mailer.rb:91:in `perform_delivery_activerecord'
    /usr/lib/ruby/gems/1.8/gems/actionmailer-2.2.2/lib/action_mailer/base.rb:526:in `__send__'
    /usr/lib/ruby/gems/1.8/gems/actionmailer-2.2.2/lib/action_mailer/base.rb:526:in `deliver!'
    /usr/lib/ruby/gems/1.8/gems/actionmailer-2.2.2/lib/action_mailer/base.rb:392:in `method_missing'
    app/controllers/users_controller.rb:47:in `create'
    app/controllers/users_controller.rb:45:in `create'



Happy hackin'
