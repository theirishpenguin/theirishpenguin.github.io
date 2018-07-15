---
comments: true
date: 2008-06-25 08:46:33
layout: post
slug: a-little-help-on-importing-gmail-contacts-using-ruby-on-rails
title: A Little Help on Importing Gmail Contacts using Ruby on Rails
wordpress_id: 75
tags:
- Programming
- RubyIreland
- Rubyonrails
---

We came across a fabulous article on getting your RoR app to pull contacts from your Gmail account at Atlantic Domain Solutions called "Import Gmail Contacts using Ruby on Rails" (link http://rorblog.techcfl.com/2008/04/18/import-gmail-contacts-using-ruby-on-rails is no longer available). Kudos to Atlantic Domain Solutions! This is a really great article. The only slight issue is that it omitted a couple of details which may confuse the newbie - in particular, where does all the code in points 1, 2 and 3 go and how do the code snippets relate to each other.

So here's a set of clarifications to the original article (a 'meta-guide' if you will), as we didn't want to just rip off these nice folks source code. Thus read these clarifications in conjunction with the original Atlantic Domain Solutions guide.

We'll assume that you know how to create a new rails app from scratch and create a controller. While you're following this you can use localhost as your server (eg. the default localhost:3000).

Create yourself a controller called ImportedContacts

    
    class ImportedContactsController < ApplicationController
    
        def authenticate
            # Put the code from point 1 in the Atlantic Domain Solutions article here.
    
            # Note:
            # Set the next_param to the follow on controller action. For example,
            # next_param = url_for(:action => 'authorise')
        end
    
        def authorise
            # Put the code from point 2 in the article here.
    
            # Note:
            # I changed some of the code as shown below...
            # if resp.code == "200"
            #     token = ''
            #     data.split.each do |str|
            #         if not (str =~ /Token=/).nil?
            #             token = str.gsub(/Token=/, '')
            #         end
            #     end
            #     redirect_to(:action => 'import', :token => token)
            # else
            #     redirect_to ('/')
            # end
        end
    
        def import
            # Put the code point 3 from the article here.
    
            # Some notes:
            # Put the line 'authsub_token = params[:token]' at around line 4 of this method
            # (just after the two requires). It was accidentally omitted in the original article.
            # I also changed the local variable 'contacts' to '@contacts' so that it is available to views
        end
    end


To see the contacts after importing, I created a folder called 'imported_contacts' under app/views and placed the file import.rhtml in it, containing the following code.

    
    <table>
      <%= @contacts.map { |c| "<tr><td>Name: #{c['name']}</td><td>Email: #{c['email']}</td></tr>" } %>
    </table>


Ok! You should be ready to rock! Ensure that you are not logged into gmail and visit http://localhost:3000/imported_contacts/authenticate

You should be brought to a Google account login page. Login and you will be brought to the Google page for allowing third party access to the Google API. Click 'Grant' and you should be brought to your app's import.rhtml page which should hopefully be displaying all your lovely contacts! Hurrah!