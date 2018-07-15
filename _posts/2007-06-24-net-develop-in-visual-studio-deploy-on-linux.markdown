---
comments: true
date: 2007-06-24 18:25:30
layout: post
slug: net-develop-in-visual-studio-deploy-on-linux
title: .NET - Develop in Visual Studio, Deploy on Linux
wordpress_id: 44
tags:
- .NET
- Linux
- Programming
---

Recently, a new product has hit the market for those folks who would like to develop in .NET, and in particular Visual Studio, but prefer to run their application on Linux.

Although you could already code up .NET solutions in MonoDevelop - which itself has made great progress recently - most enterprises will only want to write .NET server and web apps in Visual Studio. Mainsoft has seen the gap in the market and filled it with a free plugin for Visual Studio, called [Grasshopper](http://xml.sys-con.com/read/393685.htm), which lets you deploy to Linux. It achieves this by compiling the application to Java bytecode rather than the .NET intermediate language and also leverages work done in the Mono project, which has already done much work in bringing .NET to Linux.

In other news, Silverlight has been successfully ported to Linux through an incredible hackathon effort by Miguel de Icaza and his Mono team! Going under the name of Moonlight, the port was pretty much wrapped up in 21 days - so it's amazing to think that with all this going on Miguel has any time to keep [his blog](http://tirania.org/blog/archive/2007/Jun-21.html) updated!
