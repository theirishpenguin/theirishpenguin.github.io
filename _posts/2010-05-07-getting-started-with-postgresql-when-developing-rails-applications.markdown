---
comments: true
date: 2010-05-07 06:24:31
layout: post
slug: getting-started-with-postgresql-when-developing-rails-applications
title: 'Getting started with PostgreSQL when developing Rails applications '
wordpress_id: 545
tags:
- database
- postgresql
---

If you're familiar with MySQL and trying out PostgreSQL for the first time while doing some Ruby on Rails development, things can initially seem quite unfamiliar. A great first article to look at is available on the OLM on Rails site at [Switching Rails to PostgreSQL](http://olmonrails.wordpress.com/2008/08/12/switching-rails-to-postgresql/). Also at this early stage in your PG career you'll need to know how to change things like user passwords so check the Examples section of the [PostgreSQL Alter User docs](http://www.postgresql.org/docs/8.0/interactive/sql-alteruser.html).

Ok, after that you should know how to create a database in PostgreSQL, hook up to a Rails app and run migrations. Once that's done, you'll need to be able to do the same things that you were able to do in MySQL in the psql shell. Here's the first commands you need...



	
* typing 'help' displays help at any time

	
* \? displays help with psql commands

	
* \l lists databases

	
* \c some_database connects to a database

	
* \c with no argument tells you what database you're currently connected to

	
* \ds lists schemas within the currently selected database. A schema is simply a namespacing of tables within a given database

	
* \dt lists tables in the currently selected database

	
* \du lists all postgres database user accounts (more detail [here](http://archives.postgresql.org/pgsql-admin/2005-07/msg00073.php))


Here's  a list of good of stuff...

	
* The 'LIKE' pattern matcher in Postgres is case sensitive (in MySQL it is case insensitive - to get this behaviour in Postgres use 'ILIKE')

	
* [What are schemas in PostgreSQL?](http://sql-info.de/postgresql/schemas.html)

	
* If you want to keep things simple, just forget about schemas and everything will end up in a 'public' schema (but you should read about schemas briefly so that they don't drive you mad when administering your postgres database)

	
* [Postgres Gotchas](http://sql-info.de/postgresql/postgres-gotchas.html)

	
* [Switching from MySQL to PostgreSQL - tips, tricks and gotchas?](http://stackoverflow.com/questions/772111/switching-from-mysql-to-postgresql-tips-tricks-and-gotchas)


