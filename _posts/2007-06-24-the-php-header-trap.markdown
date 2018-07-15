---
comments: true
date: 2007-06-24 17:48:11
layout: post
slug: the-php-header-trap
title: The PHP Header() Trap
wordpress_id: 43
tags:
- Programming
---

This is just a quick tip for young players - new to the PHP game. The rather sexy header() function can be used to redirect the user from one page to another. But an important point about this function is that you cannot send ANY html or empty lines or spaces (or anything) to the client browser prior to calling the header() function.

This sounds easy to guard against but it isn't always obvious. You could include a file using include(), require() or require_once() and it could be the culprit. This hit home particularly hard today when it turned out that out database connection file had empty lines after the closing php tag "?>"

Ironically, if the empty lines had been located before the closing php tag then everything would have been fine, as they would not have been sent to the client - c'est la vie! The solution became apparent after stumbling across this [page](http://us3.php.net/manual/en/function.header.php) which spelt the problem out clearly.
