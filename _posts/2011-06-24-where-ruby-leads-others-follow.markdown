---
comments: true
date: 2011-06-24 01:13:11
layout: post
slug: where-ruby-leads-others-follow
title: Where Ruby leads, others follow...
wordpress_id: 1043
tags:
- Opinion Piece
- RubyIreland
- Rubyonrails
- choice
- ireland
- rails
- ruby
- web
---

In response to the question and comments on a recent linked in post discussing the suitability of various web platforms, including Ruby on Rails...

### The first big decision
Firstly, whatever you choose, I would suggest using a platform that is Open Source. This means that the stack is effectively commoditised - giving access to a high quality platform that keeps your costs low today and into the future as you scale out and avoid being locked into the release cycle of one particular vendor. A big plus is that anytime you hit a problem, your engineers can drill right down into platform to diagnose and resolve it. This is a formula that's worked for for Google, Groupon, Amazon, Twitter and Facebook to mention a few.

### Enter Ruby
I am of the opinion that Ruby and Rails is the likely the best web framework to use to build the vast majority of web applications out there. Since it's release, Rails has lead the way in terms of web development - promoting the Model-View-Controller pattern in a simple, easy-to-use manner as a way of creating web applications. Whilst that pattern has been around for a while Rails really put it on the radar for web apps. Along with it came a shift from unpopular SOAP webservices to a RESTful service architecture. And so too did easy to use AJAX techniques for building richer UI's because Rails bundled the Prototype library with it from an early stage. Rails has since continued to lead by incorporating the latest Javascript technologies into its ecosystem - such as node.js.

### Dynamic Language = Dynamic Business
Because of the dynamic nature of the language, its strong use of conventions and the style of Ruby developers, you end up having much less code in your application. This win in terms of a smaller codebase is also true of projects developed using other dynamic languages such as Python. A smaller codebase has the usual touted benefits in terms of rapid development times and a more easily managed codebase. In particular, less boilerplate code.

Using dynamic over static typing means that you have to have to write automated tests to cover your code. Some developers disagree with dynamic typing and say that the compile time checking of a static language is important. In my experience, this is not so. By writing automated tests to cover business cases I've found that I catch a much more important class over of errors - business logic issues - while also covering the code paths for the edge cases that the static compiler would have checked. One of the ways static languages try to provide some of the flexibility of dynamic languages is through generics. This quickly leads to a type of complexity which I have found is much better, and more clearly handled, using a dynamic language. The clarity of the code, the ease of testing and the expressiveness and power of a language like Ruby has firmed up my thinking on this area. As a platform which has baked testing right into the core of its ethos, Ruby and Rails has lead the way in terms of integrating automated test frameworks into the developer's workflow. And a higher level, it has made it possible to bring business stakeholders and development teams together by introducing tools that allow one to express business features in terms that can easily be discussed with, implemented and tested by a developer. Cucumber is probably the best example of this, which like many other Ruby projects has caused a massive stir in the web community.

### And the bad news...
So what are the pitfalls. I'd agree that it is harder to find Ruby developers. Whilst many top tech locations have a massive amount of Ruby developers - such as San Fran or London - Ireland doesn't have those numbers. This is partially because we have lagged behind the technology curve a little in the past. But I'm happy to say that this is something that has changed immeasurably over the last couple of years. There is a lot more developer meetings and grassroots activity, predominantly in those with an Open Source slant. This is a good news story not just for Ruby, but for the whole Irish tech sector. And I'm sure that strong confident Irish companies will emerge as a result.

Some companies do decide that certain parts of their solution are best written in a different language. There are some well tried paths to doing this with Ruby. For example, you can use JRuby to easily farm out some parts of your codebase to Java while retaining development agility for the rest of your codebase by keeping it in Ruby. However, needing to do this is very much the exception rather than the norm.

### Building services and deployment
You indicated that you will be writing a service rather than a full fledged web application - another option you could consider is using the Ruby-based Sinatra as your web framework instead of Rails - which is a thinner layer, which some people prefer for building services such as github. That said, I would still personally go with Rails as there are more tutorials and guides available - particularly if it is your companies first time working with Ruby.

For deployment, Heroku makes developing and deploying Ruby apps a breeze. It really is an exceptional platform which sits on top of Amazon's AWS. I would recommend taking a serious look at it at http://www.heroku.com before making a decision on which platform to choose.


So, all in all, my long standing impression of Ruby and Rails is that it is web development done right. It has been the leader in pushing forward how developers and businesses develop websites and consigned the sprawling mess that existed before it to history. In the meantime other platforms have tried to copy some of its features, often less elegantly. As the same time Rails has accelerated the rate at which it pushes forward the web - the next release Rails 3.1 is breathtaking in its feature list. 

For these reasons I think Ruby is 'the' web development language of the next decade. Whatever you decide, all the best with your venture. There are plenty of excellent platforms out there to choose from so it's a great time to be building the kind of high-scale web applications and services.
