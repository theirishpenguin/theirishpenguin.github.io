---
comments: true
date: 2007-07-01 13:24:51
layout: post
slug: qobject-qmake-and-sadness-undefined-reference-to-vtable
title: QObject, QMake and Sadness - 'Undefined reference to vtable'
wordpress_id: 46
tags:
- Frogface
- Programming
---

Mmmm... Bit of a longwinded title there! Basically, I could not shake off the following error recently, when writing a class Browser which inherited from QObject. Apparently, the answer is that sometimes you simply have to delete your Makefiles and regenerate them using QMake (KDevelop automatically creates Makefiles from me if none are found), in order to get over this error.


    /path/to/frogface/trunk/src/browser.cpp:38:
    undefined reference to `vtable for Browser'
    browser.o: In function `Browser':
    /path/to/frogface/trunk/src/browser.cpp:34:
    undefined reference to `vtable for Browser'
    /path/to/frogface/trunk/src/browser.cpp:34:
    undefined reference to `vtable for Browser'
    collect2: ld returned 1 exit status
    gmake[1]: *** [../bin/frogface] Error 1
    gmake: *** [sub-src-make_default] Error 2
    *** Exited with status: 2 ***

Thanks to the patient folks on the QT mailing for the help!

Funnily enough as I write this, someone's just posted the following checklist on the #qt irc channel, which is good advice
	
1. Make sure the Q_OBJECT macro is present in the definition of all QObject-derived classes

	
1. Make sure you define your QObject-derived classes in your header files ONLY

	
1. Make sure all of your header files are listed in your .profile in the HEADERS=list

	
1. Run qmake every time you add Q_OBJECT to one of your classes or modify your .pro file

The last one is particularly important as I've made an art form out of forgetting it :)
