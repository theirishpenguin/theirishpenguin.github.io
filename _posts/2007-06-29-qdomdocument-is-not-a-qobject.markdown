---
comments: true
date: 2007-06-29 12:43:26
layout: post
slug: qdomdocument-is-not-a-qobject
title: QDomDocument is not a QObject
wordpress_id: 45
tags:
- Linux
- Programming
---

Aha! Here's one that caught me out for a while. I was writing a class that inherited from QDomDocument and was more than a bit puzzled when I got the error


    moc_fdom.cpp:37: error: 'staticMetaObject' is not a member of 'QDomDocument'
    moc_fdom.cpp: In member function 'virtual void*
    JsDomDocument::qt_metacast(const char*)':
    moc_fdom.cpp:51: error: 'qt_metacast' is not a member of 'QDomDocument'
    moc_fdom.cpp: In member function 'virtual int
    JsDomDocument::qt_metacall(QMetaObject::Call, int, void**)':
    moc_fdom.cpp:56: error: 'qt_metacall' is not a member of 'QDomDocument'
    gmake[1]: *** [moc_fdom.o] Error 1
    gmake: *** [sub-src-make_default] Error 2
    *** Exited with status: 2 ***

Turns out QDomDocument isn't a QObject so I was making the mistake of including the Q_OBJECT macro at the start of my class definition. D'oh!
 
    class XDomDocument : public QDomDocument
    {
        Q_OBJECT //Don't do this!!!
        public:
            XDomDocument();
    }

A side effect of not being a QObject is that you cannot wire up signals and slots in the normal manner. Although googling around should bring up a few workarounds.
