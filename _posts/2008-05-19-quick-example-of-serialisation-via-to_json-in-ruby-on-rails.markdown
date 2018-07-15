---
comments: true
date: 2008-05-19 09:41:53
layout: post
slug: quick-example-of-serialisation-via-to_json-in-ruby-on-rails
title: Quick Example of Serialisation via to_json in Ruby On Rails
wordpress_id: 73
tags:
- Geek
- Programming
- RubyIreland
- Rubyonrails
---

Ruby On Rails provides a few neat ways to serialise/deserialise objects to JSON. Out of the box you get the following approaches

SERIALISING

    
    json_string = a_house.to_json


DESERIALISING

    
    an_object = ActiveSupport::JSON.decode(json_string) # gives you an object of type Object

    a_house.from_json(json_string) # gives you an object of type House, note that a_house
                                   # is an instance of House


These are pretty straightforward and do exactly what they say on the tin. Of the deserialising methods, note that using ActiveSupport directly gives you an object of type Object so you may prefer the stronger typing of the second technique which gives you an actual House object.

**Note:** There's  been some great improvements to JSON support built right into Rails since Rails 2 has come around. For more info on this see [here](http://blog.codefront.net/2007/10/10/new-on-edge-rails-json-serialization-of-activerecord-objects-reaches-maturity/).

**When things just aren't enough...**
There are times when you will want to override the default serialisation that Rails provides - such as if you want to do some object 'flattening' like including an attribute from an association on serialising. Now before proceeding check out the latest Rails 2 JSON support mentioned at the end of the previous section as this might make your life a lot easier. Otherwise, let's press on with an example of DIY JSON handling.

Given a House object which has an associated Owner object, you might want to include the Owner's name attribute when serialising a House.

House Class

* has address and value attributes
* has an associated Owner object

Owner Class

* has a name attribute

We'll need to override the default to_json method on the House model.

    
    class House::Base
      def to_json
        result = Hash.new
    
        self.class.content_columns.each do |column|
          if self.attributes.include?(column.name)
            result[column.name.to_sym] = self.send(column.name)
          end
        end
    
        if self.attributes.include?(column.name)
          result[:owner_name] = owner.name
        end
    
        result.to_json
      end
    end


The above was partially taken from the howtogeneratejson at http://wiki.rubyonrails.org/rails/pages/howtogeneratejson page on the Rails wiki (which is no longer available), which is has little bit more detail. Now all you need to do is call the a_house.to_json method and you get lots of lovely JSON which represents your model! One final note is that you may not want to override the default to_json method. If not, just call your method something else like to_custom_json. Also, there's
