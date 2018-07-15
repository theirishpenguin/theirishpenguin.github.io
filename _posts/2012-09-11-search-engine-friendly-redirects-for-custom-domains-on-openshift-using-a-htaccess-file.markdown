---
comments: true
date: 2012-09-11 22:58:10
layout: post
slug: 2012-09-11-search-engine-friendly-redirects-for-custom-domains-on-openshift-using-a-htaccess-file.markdown
title: "Search Engine Friendly Redirects for Custom Domains on OpenShift using a .htaccess file"
wordpress_id: 1046
image: http://thenewstack.io/wp-content/uploads/2016/05/Open_Shift.png
tags:
- ruby
- openshift
- seo
- custom domain
- apache
- redirect
- htaccess
---

[OpenShift](https://openshift.redhat.com) provides an easy way to
host your Ruby based blogs (built on
Sinatra or Jekyll) or Wordpress site, without incurring expense. Being
content heavy, these kind of apps should really not have
[duplicate content](http://en.wikipedia.org/wiki/Duplicate_content) on different domains out there on that crazy ass Internet. Them spiders just won't like you as much!

So what do you do when you have your app at
`http://foo-example.rhcloud.com` and `http://www.example.com` because
you've set up a [custom
domain](https://openshift.redhat.com/community/blogs/custom-url-names-for-your-paas-applications-host-forwarding-and-cnames-the-openshift-way) - will that split your SEO Google juice?

The solution is to use a bit of
[.htaccess](http://httpd.apache.org/docs/current/mod/mod_rewrite.html) magic in order to use
permanent 301 redirects to shepherd on traffic arriving at
http://foo-example.rhcloud.com to http://www.example.com

### Solution for Ruby

Here's a example .htaccess file for a Jekyll/Sinatra hybrid app. It can
be dropped under your example\_app/public directory.

(Note: public can be used instead of a \_site directory
for convenience on OpenShift)

    <IfModule mod_rewrite.c>
    RewriteEngine On
    </IfModule>

    RewriteCond %{HTTP_HOST} ^foo-example.rhcloud.com$
    RewriteRule (.*)$ http://www.example.com/$1 [R=301,L]

But if you rebuild a Jekyll site locally it will blow away the .htaccess
file if you put it under your example\_app/public directory. So I leave
it in the root directory. Then you can use a `action hook` to move it
from the root directory of your app to under the example\_app/public
directory. Here it is and you can put it in the file `example_app/.openshift/action_hooks/deploy`

    # Move .htaccess from root folder to public folder on every deploy
    mv $HOME/app-root/repo/.htaccess $HOME/app-root/repo/public/.htaccess
    
    # Paranoidly ensuring sane permissions (in case we check in dodgy perms)
    chmod 644 $HOME/app-root/repo/public/.htaccess

The last line ensures that the .htaccess file has the correct
permissions. If you have a Wordpress site instead you should still carry
`chmod 644 example_app/php/.htaccess` before you check it into git the
first time - just to be on the safe side.

### Solution for Wordpress

Here's a example .htaccess file for a Wordpress site, which you can drop
under your example\_app/php directory. Just replace
foo-example.rhcloud.com with your app URL and http://www.example.com
with your custom domain URL.

    # BEGIN WordPress
    <IfModule mod_rewrite.c>
    RewriteEngine On
    RewriteBase /
    RewriteCond %{REQUEST_FILENAME} !-f
    RewriteCond %{REQUEST_FILENAME} !-d
    RewriteRule . /index.php [L]
    </IfModule>
    # END WordPress

    RewriteCond %{HTTP_HOST} ^foo-example.rhcloud.com$
    RewriteRule (.*)$ http://www.example.com/$1 [R=301,L]

Again, remember to do a chmod 644 on the .htaccess file like above in the
Ruby section to ensure it has the correct permissions.

### Testing

With all the above in place, your next `git push` should
deliver you the redirecting experience you are looking for! Just visit
your app URL at http://foo-example.rhcloud.com and hopefully you are
whisked away to your custom domain URL. Thanks to the guys on the OpenShift
forums, especially kpendic and statikip for taking the time to help out with this.

Till the next time, keep it Shifty!
