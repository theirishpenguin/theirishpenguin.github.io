---
comments: true
date: 2009-11-26 09:33:59
layout: post
slug: generate-rails-migrations-from-your-postgresql-or-mysql-database
title: Generate Rails Migrations from your PostgreSQL or MySQL database
wordpress_id: 398
tags:
- Programming
- RubyIreland
- Rubyonrails
- database
- dump
- migrations
- rails
- ruby
- schema
---

1. Create a new empty Rails project called schemer

2. In your config/database.yml file, point at the database you wish to dump to a migrations file

3. Run the command `rake db:schema:dump` This should create a db/schema.rb file. Amazingly this effectively is your migrations file!

4. To tidy up create a file called file `db/migrate/20091125205635_create_initial_schema.rb`

5. Then copy the create_table statements from the schema.rb file into the new file `20091125205635_create_initial_schema.rb` Here's a template
    
       class CreateInitialSchema < ActiveRecord::Migration
    
           def self.up
               # Put all create_table statements from schema.rb file here
               # Note: You don't need the 'ActiveRecord::Schema.define(:version'
               # line or it's enclosing end statement
               # ...
               # ...
           end
    
           def self.down
               # Don't really need this
           end
    
       end

6. Once you've all this done you can just run `rake db:migrate` and you should have a new sqlite db up and running under db/development.sqlite3

Thanks to Justin Ball on this Nobody Listens Anyway blog at [Dump an Existing Database Schema Into a Ruby On Rails Migration Ready Format](http://www.justinball.com/2008/05/09/dump-an-existing-database-schema-into-a-ruby-on-rails-migration-ready-format/) for the basis of this tip. Sometimes somebody does...
