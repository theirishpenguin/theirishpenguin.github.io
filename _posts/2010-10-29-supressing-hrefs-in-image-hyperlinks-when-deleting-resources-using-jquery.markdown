---
comments: true
date: 2010-10-29 11:55:58
layout: post
slug: supressing-hrefs-in-image-hyperlinks-when-deleting-resources-using-jquery
title: Supressing hrefs in image hyperlinks when deleting resources using jquery
wordpress_id: 971
tags:
- Programming
- javascript
- jquery
- Rubyonrails
---

This week we're trying to delete a resource using jquery within a Rails 2.3 app. First thing to note when using Rails is that if you set :method => :delete like below you will get a whole bunch of obtrusive prototype library javascript injected into the hyperlinks onclick() event. This can clash with your jquery code so you can't use :method => :delete alongside jquery. And it doesn't make any sense to do it this way. The number one reason that someone  (err... yes, me!) will get into this mess is that they've been using the image_tag and link_to helper's and just forgotten that all this extra prototype code will be generated. So this is not so good for what we want...

    <%= link_to image_tag('/images/delete.png', :title => 'Delete the thing', :class => 'clearPrintQueueOnClick'), '/things/3', :method => :delete %>

But this is better...

    <%= link_to image_tag('/images/delete.png', :title => 'Delete the thing', :class => 'deleteThingOnClick'), '/please_enable_javascript.html' %>

Note: That we have jquery code set up against anything that has the class deleteThingOnClick.

Ok, if the user's browser does not have javascript enabled it will take them to the `please_enable_javascript.html` which you can drop in your public html. If you want to support non-javascript browsers you can create a page with a form for doing delete requests - an example is shown in this blog [entry](http://gaskell.org/unobtrusive-deleting-with-rails-and-jquery/) by Andy Gaskell.

With those pitfalls out of the way, all that remains to do to supress the href is to add event.preventDefault(); to the start of your deleteThingOnClick handler

    $("a").click(function(event) {
        event.preventDefault();
        // rest of your deletion code goes here..
    }

That's it really! Exit stage left...