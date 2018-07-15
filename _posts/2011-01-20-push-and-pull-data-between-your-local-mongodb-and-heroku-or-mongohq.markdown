---
comments: true
date: 2011-01-20 08:18:46
layout: post
slug: push-and-pull-data-between-your-local-mongodb-and-heroku-or-mongohq
title: Push and pull data between your local MongoDB and Heroku or MongoHQ
wordpress_id: 1019
tags:
- Geek
- Programming
- RubyIreland
- Rubyonrails
- database
- heroku
- mongo
- mongoid
- pull
- push
- rails
- ruby
---

Heroku do a great job of providing a free way to host MongoDB. The only slight issue I had was syncing data between my machine and my Heroku apps - in the way I was used to with their Taps plugin which works for Postgres databases. But here's how to do it for MongoDB. Note, I was using it with a Rails 3 and Ruby 1.9.2 app.

Firstly you need to get Pedro Belo's super plugin [heroku-mongo-sync](https://github.com/pedro/heroku-mongo-sync) . The docs say that the default way to use it is just to do a 'heroku mongo:push' or 'heroku mongo:pull' from inside your app directory on your machine. But this takes the name of your app exactly and assumes that this is the name of your mongo database. Unfortunately, many people like to call their database something else - and even the default is yourappname_development which won't work (it must be 'yourappname' exactly).

A feature allowing you to specify a MONGO_URL shell variable that will let you override this is in the README. Sadly it didn't work for me. But help is at hand - we can just create a new enviroment for syncing and then specify the database we need as the default. Of course you don't have to do this if your database is actually exactly the same as your app already; though the following approach may still serve you well as a workflow

* Pre-requiste, you must have an account setup on [MongoHQ](https://mongohq.com) for this to work. And see [here](http://docs.heroku.com/mongohq) for how to setup MongoDB on Heroku
* Copy your config/development.rb to config/sync.rb
* Ok, I'm using Mongoid. Here's how I define my db connection to be exactly the same as my app's name in my config/mongoid.yml file

      sync:
      <<: *defaults
      database: yourappname

* Whenver you want to push or pull to Heroku just change the default Rails environment at the top of your config/application.rb file to be 'sync'

      require File.expand_path('../boot', __FILE__)
      ENV['RAILS_ENV'] = 'sync'

* Now from the command line, you should find 'heroku mongo:push' and 'heroku mongo:pull' work like a dream. Ahoy, me mongols!
