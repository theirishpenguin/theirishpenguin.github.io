---
comments: true
date: 2010-08-10 11:29:49
layout: post
slug: ruby-bindings-for-qt-building-qtruby-on-meego-and-creating-an-rpm
title: 'Ruby Bindings for Qt: Building QtRuby on MeeGo and creating an RPM'
wordpress_id: 868
tags:
- Programming
- Rubyonrails
- bindings
- build
- deb
- kde
- meego
- package
- qt
- rpm
- ruby
---

MeeGo is great. What could make it even better? More Ruby :-) So what better way to achieve this than by getting the Ruby bindings for Qt up and running on MeeGo. So here's a Work In Progress guide...

### Pre-requisites

Get the MeeGo SDK running on your machine under Xephyr [http://wiki.meego.com/MeeGo_SDK_with_Xephyr](http://wiki.meego.com/MeeGo_SDK_with_Xephyr)
I'll assume that you can successfully run the `meego-sdk-chroot` command and are now at a MeeGo console. Here's what we need to do to build QtRuby...

### The Guide

Install cmake:

    zypper in cmake

Pull down the kdebindings source code from svn:

    svn checkout -N svn://anonsvn.kde.org/home/kde/trunk
    cd trunk
    svn up -N KDE
    cd KDE
    svn up kdelibs kdebindings
    
The above should be all you need to do but if you have problems then maybe try reading http://en.opensuse.org/openSUSE:KDE_developers_guide

Copy the `kdebindings/qtruby` directory to your meego home directory in the `<meego_sdk_directory>`, the latter will be something like `/home/yourusername/meego-sdk-0524/home/meego/` depending on where you installed the MeeGo SDK earlier.

Copy the file `kdebindings/CMakeLists.txt.qtruby` to `/home/meego/qtruby/CMakeLists.txt` (yes, this will overwrite the old file. This is ok, we don't want to build all of kdebindings, just qtruby)

    cd <meego_sdk_directory>/home/meego/qtruby

Edit the new CMakeLists.txt, underneath the line `include (MacroOptionalFindPackage)` add the lines:

    include (MacroOptionalAddBindings)
    include (MacroLogFeature)
    include (CheckCXXSourceCompiles)

Also, just before the line `add_subdirectory(smoke)` add the line:

    add_subdirectory(generator)

Finally, if you want to be able to build an RPM (or any other package type supported by the [CPack](http://www.cmake.org/Wiki/CMake:CPackPackageGenerators) tool), add the following line as the very last line in the `CMakeLists.txt` file:

    include(CPack)

Ok now we need to create a `cmake/modules` directory

    mkdir -p qtruby/cmake/modules
    cd qtruby

As the `CMakeLists.txt` file says in the commented section, we need to copy some files we need from the KDE related directories (this is because we are building QtRuby standalone instead of as part of the all-encompasing kdebindings module). Note, you need to change the location of kdelibs in the next command to wherever you pulled down the subversion directory

    cp kdelibs/cmake/modules/FindQt4.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/FindRUBY.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/MacroOptionalFindPackage.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/MacroPushRequiredVars.cmake ./cmake/modules/

Additionally you will need to copy the following files

    cp kdelibs/cmake/modules/Qt4Macros.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/Qt4ConfigDependentSettings.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/HandleImportedTargetsInCMakeRequiredLibraries.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/MacroLogFeature.cmake ./cmake/modules/
    cp kdelibs/cmake/modules/CheckCXXSourceCompiles.cmake ./cmake/modules/

And also copy these from kdebindings

    cp kdebindings/cmake/modules/MacroOptionalAddBindings.cmake ./cmake/modules/
    cp -r kdebindings/ruby .
    cp -r kdebindings/smoke .
    cp -r kdebindings/generator .

Now we are going to create a `qtruby_build` directory so that we can do an out-of-source build of qtruby. If you don't know what an out-of-source build is, don't worry!

    cd ..
    mkdir qtruby_build
    cd qtruby_build

Create a file called `cmake_qtruby`. Copy and paste the long commented cmake command in `CMakeLists.txt` to this file (you can exclude the make and make install commands)

At the end of the last line of this command add a backslash (so that you can continue the command on the next line) and then add the line:

    ../qtruby

Then change the cmake command options

    -DRUBY_EXECUTABLE=/usr/bin/ruby
    -DRUBY_INCLUDE_PATH=/usr/lib/ruby/1.8/i386-linux/ 

At the end of this step the file should look something like

    cmake                                                         \
      -DCMAKE_INSTALL_PREFIX=/usr/local                           \
      -DRUBY_EXECUTABLE=/usr/bin/ruby                             \
      -DRUBY_INCLUDE_PATH=/usr/lib/ruby/1.8/i386-linux/           \
      -Wno-dev                                                    \
      -DENABLE_SMOKE=on                                           \
      -DENABLE_QTRUBY=on                                          \
      -DENABLE_QTWEBKIT_SMOKE=off                                 \
      -DENABLE_QTSCRIPT_SMOKE=off                                 \
      -DENABLE_QTUITOOLS_SMOKE=off                                \
      -DENABLE_QTTEST_SMOKE=off                                   \
      -DENABLE_PHONON_SMOKE=off                                   \
      -DENABLE_QSCI_SMOKE=off                                     \
      -DENABLE_QWT_SMOKE=off                                      \
      -DENABLE_KDE_SMOKE=off                                      \
      -DENABLE_KDEVPLATFORM_SMOKE=off                             \
      -DENABLE_KHTML_SMOKE=off                                    \
      -DENABLE_KTEXTEDITOR_SMOKE=off                              \
      -DENABLE_SOLID_SMOKE=off                                    \
      -DENABLE_PLASMA_SMOKE=off                                   \
      -DENABLE_QTWEBKIT_RUBY=off                                  \
      -DENABLE_QTUITOOLS_RUBY=off                                 \
      -DENABLE_QTSCRIPT=off                                       \
      -DENABLE_QTTEST=off                                         \
      -DENABLE_PHONON_RUBY=off                                    \
      -DENABLE_QSCINTILLA_RUBY=off                                \
      -DENABLE_QWT_RUBY=off                                       \
      -DENABLE_SOPRANO_RUBY=off                                   \
      -DENABLE_KDEVPLATFORM_RUBY=off                              \
      -DENABLE_KORUNDUM_RUBY=off                                  \
      -DENABLE_KHTML_RUBY=off                                     \
      -DENABLE_KTEXTEDITOR_RUBY=off                               \
      -DENABLE_SOLID_RUBY=off                                     \
      -DENABLE_KROSSRUBY=off                                      \
      -DENABLE_PLASMA_RUBY=off                                    \
      -DENABLE_QIMAGEBLITZ_SMOKE=off                              \
    ../qtruby

Make this command executable and run it

    chmod u+x cmake_qtruby
    ./cmake_qtruby

This should go off prepare your `qtruby_build` directory for compiling. Once it is finished, you should be able to install by any one of the following methods

### RPM-based Install

You will need to have added the `include(CPack)` to the `CMakeLists.txt` file as outlined earlier before running cmake. You also now need to install the following:

    zypper install rpm-build
    zypper install meego-rpm-config # Maybe you dont need this but I installed it anyway

Now all you need to do is run `make package` and then `cpack -G RPM` to build the RPM. You will find that the generated RPM install is called `kdebindings-0.1.1-Linux.rpm`. That's because we were originally pulled all our qtruby code out of the kdebindings codebase - you can customize the package name, version and much much more by passing parameters to the cpack command when generating the rpm. You can check what values were used to build the package by viewing the `CPackSourceConfig.cmake` file. As I was just building this rpm for personal use, I didn't bother changing any package details. Tut! Tut! Anyway, once you have an rpm you are happy with, simply install the QtRuby bindings on your system via:

    rpm -i <your_generated_rpm_name>

Note: If you want to see the RPM spec file generated, have a look at `_CPack_Packages/Linux/RPM/SPECS/kdebindings.spec`

### Deb-based Install (and other package types) 

This is pretty much identical to the RPM-based Install. The difference is to use `cpack -G DEB` instead of `cpack -G RPM`

### Source-based Install

All need to do `make` and `make install` to get the QtRuby bindings installed onto your system. Not quite as easy to undo as an package based installation though!

### Testing that everything works

I only tested the RPM package installation method. I found that when running the `rbqtapi` command I got the following error

    /usr/lib/ruby/site_ruby/1.8/i386-linux/qtruby4.so: libsmokeqtcore.so.3: cannot open shared object file: No such file or directory - /usr/lib/ruby/site_ruby/1.8/i386-linux/qtruby4.so (LoadError)
	from /usr/lib/ruby/site_ruby/1.8/Qt4.rb:5
	from /usr/local/bin/rbqtapi:6:in `require'
	from /usr/local/bin/rbqtapi:6

This was because some of the qtruby libraries installed into `/usr/local/lib` which my MeeGo system does not check for libraries by default. I changed this by adding the file `/etc/ld.so.conf.d/qtruby-i386.conf` which simply contained the line:

    /usr/local/lib

And then running the `ldconfig` command. Then the `rbqtapi` command worked happily!

This guide still needs some polish. We'll get to that eventually, but hopefully it may be of some use in getting the Ruby and Qt playing real nice together on MeeGo!
