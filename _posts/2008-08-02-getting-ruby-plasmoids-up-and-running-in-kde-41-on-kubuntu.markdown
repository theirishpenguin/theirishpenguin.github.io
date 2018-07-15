---
comments: true
date: 2008-08-02 23:24:12
layout: post
slug: getting-ruby-plasmoids-up-and-running-in-kde-41-on-kubuntu
title: Getting Ruby Plasmoids up and running in KDE 4.1 (on Kubuntu)
wordpress_id: 76
tags:
- Linux
- Programming
- RubyIreland
- Rubyonrails
- Ubuntu
---

**NOTE:** THIS ARTICLE IS NOT YET COMPLETE. IF YOU FOLLOW IT THEN YOU WILL GO A LONG WAY BUT THE PLASMOID IS NOT YET DISPLAYING. SEE THE 'Run your applet' SECTION NEAR THE END OF THIS ARTICLE BEFORE PROCEEDING.

### Introduction
KDE 4.1 is an absolutely terrific release of the KDE desktop, licking most of the issues presented in the original 4.0 release. Although it is still an early adopter release, 4.1 will be of interest to techie's who want to get their mitts on a sexy new graphical interface and is reasonably stable for daily usage. Not quite ready for Aunt Tillie yet though! One of the nicest features is the beauty and simplicity of Plasmoids and these super flexible little gadgets can now be written in Ruby - well almost!

This guide assumes that you're using Kubuntu Hardy Heron. But you should be able to adjust the instructions for any distro.



	
  * The starting point for our tour is to have Ruby installed. Google this if you're unsure as to whether or not it's installed.

	
  * We need to install cmake via 'sudo aptitude install cmake'. This is a cross-platform build system, similar to make.

	
  * It's likely that you will need to install the build UNIX build tools via 'aptitude search build-essential'.


### Get coding!
And now you're be ready to go. The main tutorial out there on Ruby Plasmoids at time of writing is the [Ruby Applet tutorial on KDE Techbase](http://techbase.kde.org/Development/Tutorials/Plasma/RubyApplet). This is a very good, well written guide on creating a simple Ruby applet in which a web browser is embeded inside the plasmoid. But the guide has a couple of gotcha's, especially for the newbie (myself included!), so we have listed solutions to these problems as we go. In summary, use our article as an supplement to KDE Techbase's.

Ok, to start with a demo everyone wants a nicely packaged directory of files, so let's quickly put together the basic directory structure for our plasmoid - it's pretty simple!



	
  * Create a directory called 'ruby-web-applet'

	
  * Save the files [plasma-ruby-applet-web.desktop](http://websvn.kde.org/trunk/KDE/kdebindings/ruby/plasma/examples/applets/webapplet/plasma-ruby-applet-web.desktop?view=markup) and [web_applet.rb](http://websvn.kde.org/trunk/KDE/kdebindings/ruby/plasma/examples/applets/webapplet/web_applet.rb?view=markup) into this directory.

	
  * Create a file called CMakeLists.txt under your ruby-web-applet directory and paste the following code into it



    
    set(SERVICES_INSTALL_DIR /usr/lib/kde4/share/kde4/services/)
    set(DATA_INSTALL_DIR /usr/lib/kde4/share/kde4/apps/)
    
    FIND_PACKAGE (Ruby REQUIRED)
    
    include_directories( ${RUBY_INCLUDE_PATH} )
    install(FILES plasma-ruby-applet-web.desktop DESTINATION ${SERVICES_INSTALL_DIR})
    install(FILES web_applet.rb DESTINATION ${DATA_INSTALL_DIR}/plasma_ruby_web_applet)


### Go to KDE Techbase
Once you have the above directory in place, go and read the [Ruby Applet tutorial on KDE Techbase](http://techbase.kde.org/Development/Tutorials/Plasma/RubyApplet) article down to just before the 'Install and test the Applet' paragraph. This will teach you what's going on in the code. At that point come back to me as I'll go into a little more detail on the final installation procedure!

### You're back!
Great! Ok, so we have the files on disk, you have a good idea of what the code is doing, now let's install it and kick your plasmoid into action!

Open the CMakeLists.txt file listed above in a text editor. Change the path listed for KDE4 services and data directories to the ones on your system. These are the lines to change.

    
    set(SERVICES_INSTALL_DIR /usr/lib/kde4/share/kde4/services/)
    set(DATA_INSTALL_DIR /usr/lib/kde4/share/kde4/apps/)




> Do this by replacing '/usr/lib/kde4/share/kde4/services/' with the output of the command 'kde4-config --install services' and replace '/usr/lib/kde4/share/kde4/apps/' with the output of the command 'kde4-config --install data' command. If you are using Kubuntu then they should be the same as mine but otherwise you may need to change them.


Then make sure you are inside your ruby-web-applet directory and type


> cmake .


to generate nice makefiles for you which the make command can then use. Don't forget the trailing dot! Now type 'make' and 'sudo make install'. This will install your plasmoid code into the KDE4 services directory (you can see where this is by running 'kde4-config --install services') and your plasmoid data into the KDE4 data directory (you can see where this is by running 'kde4-config --install data'). Effectively, the installation just involves the two files - plasma-ruby-applet-web.desktop web_applet.rb. If it's worked then you'll get output like


> Install the project...
-- Install configuration: ""
-- Installing: /usr/lib/kde4/share/kde4/services/plasma-ruby-applet-web.desktop
-- Installing: /usr/lib/kde4/share/kde4/apps/plasma_ruby_web_applet/web_applet.rb


The applet is now installed!

### Run your applet (THIS DOES NOT WORK YET)
There are two ways to do this. In a developer kind of way you can run 'kbuildsycoca4' from the command line followed by 'plasmoidviewer plasma-ruby-web-applet'. Unfortunately this currently brings up the error

    
    findServiceByDesktopPath:  not found
    findServiceByDesktopPath:  not found


**IF YOU HAVE A SOLUTION TO THIS THEN PLEASE COMMENT BELOW!!! **

As a user, the cmake/make/make install procedure should have done all the necessary to install your plasmoid and you can activate it by going to the right of the task bar and clicking the Add Widgets icon. You should see your plasmoid listed but unfortunately this is not yet working - presumably for the same reason as the above. Oh well, I'm sure a solution will soon be posted. Until then, happy hackin!

### Final notes

Note that the KDE techbase article provides a version of this file but it didn't work for me because



	
  * I knew nothing about cmake or cmake files and I didn't even cop that right clicking on the CMakeLists.txt file link in their article and saving it to disk would also save a load of HTML into the file

	
  * The line 'FIND_PACKAGE (RUBY REQUIRED)' should really be 'FIND_PACKAGE (Ruby REQUIRED)' as it's case sensitive and will otherwise give you the error


> CMake Error at CMakeLists.txt:6 (FIND_PACKAGE):
find_package could not find module FindRUBY.cmake or a configuration file for package RUBY.

Adjust CMAKE_MODULE_PATH to find FindRUBY.cmake or set RUBY_DIR to the directory containing a CMake configuration file for RUBY.  The file will have one of the following names:

RUBYConfig.cmake
ruby-config.cmake




	
  * The destination targets specified in the file didn't work for me. Perhaps some environment variables need to be set somewhere

	
  * I didn't even know how to use cmake! Or that you needed to follow it up with 'make'. Anyway we'll come cover this soon!


I didn't need to set any CMAKE_MODULE_PATH but if you are having troubles with this then it's at /usr/share/cmake-2.6/Modules/ on Kubuntu Hardy Heron. You may be able to set it in your script if your having difficulties as follows 'set(CMAKE_MODULE_PATH /usr/share/cmake-2.6/Modules/)'. Again I haven't tried this my self!
