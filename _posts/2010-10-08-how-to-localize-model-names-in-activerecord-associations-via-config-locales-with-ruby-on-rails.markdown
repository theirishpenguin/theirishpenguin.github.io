---
comments: true
date: 2010-10-08 11:18:33
layout: post
slug: how-to-localize-model-names-in-activerecord-associations-via-config-locales-with-ruby-on-rails
title: How to localize model names in ActiveRecord associations via config locales
  with Ruby on Rails
wordpress_id: 944
tags:
- Programming
- RubyIreland
- Rubyonrails
- activerecord
- locales
- localization
- rails
- ruby
- translation
---

Argghhh!!! I went bananas for a little while getting my head around this. What are we trying to achieve? Well, say let's we have a model called Consultant which has a many-to-many relationship with Company though a Contract association. The Contract model is basically sitting on topic of a simple join in the database which has consultant_id and and company_id fields.

    class Consultant < ActiveRecord::Base
      has_many :contracts
      has_many :companies, :through => :contracts
    
      accepts_nested_attributes_for :contracts
    end
    
    class Company < ActiveRecord::Base
      has_many :contracts
      has_many :consultants :through => :contracts
    end
    
    class Contract < ActiveRecord::Base
      belongs_to :consultant
      belongs_to :company
    
      validates_uniqueness_of :consultant_id, :scope => :company_id,
        :message => "cannot have a contract with the same company more than once"
    
    end


We have a New Consultant page which allows us to associate existing Companies with a Consultant by adding/removing Contracts. A Consultant cannot have a contract with a Company more than once, hence we need a validate_uniqueness_of validation on the Contract association.

But hey, business is booming! We end up needing to reuse the code base for another Rails project. The new project is in the construction domain but it has been decided that the database schema and domain model should remain unchanged. However we are told that as far as the user is concerned they should never see the term Consultant, rather they should see the term Builder. Enter translations!

Though you're not going to put your shoddy Spanish to the test and you failed French before you left school, translations are a handy way to work around this problem. Simply translate the word Consultant into Builder via the config/locales/en.yml file in your Rails project. At the same time we'll also change


  * The validation error header that is present when the user submits an invalid record

  * The displayed version of the consultant_name to be Builder Name

  * The displayed version of the consultant model name to be Builder when arising from errors on the Contract association. The way to do this is not immediately obvious - you have to translate the foreign key field (consultant_id) to Builder for the association

Here's the complete config/locales/en.yml file. Note: Whitespace and indentation is very important.
    
    en:
      activerecord:
        errors:
          messages:
          template:
            header:
              one: "This Builder has just one error but still you gotta fix it..."
              other: "This Builder has lots of errors, get your act together..."
        attributes:
          consultant:
            consultant_name: Builder Name # Handles the work of translating this attribute
          contract:
            consultant_id: Builder # NNB: This the big one! Notice how must translate the foreign key field to Builder for the association!!!
        models:
          consultant: Builder # This causes the consultant model to be referred to as Builder on the UI
    



So there you have it. The foreign key is the key, so to speak!

The best guide I encountered on translation was this one by Ian Hecker on [Translating ActiveRecord](http://iain.nl/2008/09/translating-activerecord) which is a great way to get started. There is also a somewhat overwhelming guide to translations at [Rails Internationalization (I18n) API](http://guides.rubyonrails.org/i18n.html) but is comprehensive nonetheless. Also, do look at the [en-GB.yml](http://github.com/svenfuchs/rails-i18n/blob/master/rails/locale/en-GB.yml) example at [Sven Fuchs Locale Examples](http://github.com/svenfuchs/rails-i18n/tree/master/rails%2Flocale) on GitHub.com which is where I first saw how you can define you locale file as an .rb file or yaml as above. Finally, I came across this entry on how to remove [Rails Validation Message Prefixes](http://blog.geekq.net/2009/04/09/i18n-remove-validation-message-prefix/) which I didn't try but I just mention here in case I need it in future.
