---
comments: true
date: 2010-05-04 10:47:59
layout: post
slug: doing-raw-mongodb-queries-when-using-mongomapper-with-rails
title: Doing Raw MongoDB Queries when using MongoMapper with Rails
wordpress_id: 544
tags:
- mongodb
- query
- connection
- mongomapper
- rails
---

Even though, you're using MongoMapper with Ruby and Rails, you may sometimes want to do queries using the Mongo database itself. Here's how I do it (note: there may be a better way, please post a comment).

    # Getting at the mongodb instance
    MongoMapper.database

    # Listing its collections
    MongoMapper.database.collections

    # Get at any collection while within any model (note: returns a Mongo::Cursor)
    coll = MongoMapper.database['questions'].find({})

    # Convert that collection to an array (useful!)
    coll.to_a

    # Display a collection (note: 'each' does an implicit 'to_a()')
    MongoMapper.database['questions'].find({}).each {|x| puts x.inspect}

    # In the Question model you can use this shortcut
    # collection to get at the questions collection
    collection.find({}).to_a
