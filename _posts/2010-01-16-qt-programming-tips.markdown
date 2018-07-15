---
comments: true
date: 2010-01-16 23:17:07
layout: post
slug: qt-programming-tips
title: Qt Programming Tips
wordpress_id: 441
tags:
- qt
---

This is a little more of an unusual blog post. It's going to simply house a slowly growing list of Qt tips over time. Here goes

### Tip 1

Qt has the concept of models baked in. Usually you will only want to use them if you have a list of records involved. So let's say you have a list of contacts like in an address book then this could be encapsulated in a QAbstractTableModel. If you just want to display a record in one-off fashion you can just populate a bunch of form fields (such as QLineEdits).

UPDATE: On revisiting this post 2 years later I can see I didn't have many tips to add :-)