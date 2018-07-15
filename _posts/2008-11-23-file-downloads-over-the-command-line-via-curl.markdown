---
comments: true
date: 2008-11-23 00:58:21
layout: post
slug: file-downloads-over-the-command-line-via-curl
title: File downloads over the command line via CURL
wordpress_id: 81
tags:
- Linux
- UbuntuIreland
---

This could be a pretty obvious one to a lot of people but it's just so handy. This will download a file from example.com to your local directory

    curl -O http://example.com/somefile.tar.gz

Really handy when you're administering a remote server and need to pull down files.
