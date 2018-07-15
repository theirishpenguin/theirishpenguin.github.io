---
comments: true
date: 2007-06-21 16:08:36
layout: post
slug: unexpected-postbacks
title: Unexpected Javascript Postbacks?
wordpress_id: 42
tags:
- Programming
---

This has been driving me bananas for hours. If you're finding that your javascript function is causing your page to post back to itself unexpectedly, then ensure that it returns false at the end of the function. Also [void(0)](http://www.quackit.com/javascript/tutorial/javascript_void_0.cfm) can be your friend.
