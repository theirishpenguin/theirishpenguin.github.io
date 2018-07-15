---
comments: true
date: 2010-04-26 10:25:10
layout: post
slug: using-git-svn-to-connect-to-a-subversion-repository-via-git
title: Using git-svn to connect to a Subversion repository via Git
wordpress_id: 532
tags:
- Linux
- Programming
- RubyIreland
- git
- subversion
- svn
---

This is quite simple on Linux. Here's how...

* Install git, subversion and git-svn (the latter can be installed on Ubuntu using `apt-get install git-svn`)

* Acquire a copy of an svn repository (or just a folder in the repository) as a git repository locally

  `git svn clone https://yoursubversionserver.com/svn/trunk/some_folder`

  Note: You can choose to omit the 'some_folder' at the end if you want everything in trunk. You can also be more specific about which folder you are interested in, eg.

  `git svn clone https://yoursubversionserver.com/svn/trunk/some_folder/wow/really/specifc/folder`

* Change a file in the repository and use the usual `git commit` command to commit it to a local repository

* To push changes from your local git repo to the subversion repo use

   `git svn dcommit`

* To pull down changes from the remote subversion repo to your local git repository use

  `git svn rebase`

* Just to be clear - in the last step we really did use the `git svn rebase` command to get changes from the remote repository.


> Do not use `git pull`. See the REBASE VS. PULL/MERGE section of the [git-svn docs](http://www.kernel.org/pub/software/scm/git/docs/git-svn.html) as to why
>
> Do not use `git clone/pull/merge/push` on your local git repositories that are derived from a subversion repo. See the CAVEATS section of the [git-svn docs](http://www.kernel.org/pub/software/scm/git/docs/git-svn.html) as to why

More basic examples are also list at the bottom of the [git-svn docs](http://www.kernel.org/pub/software/scm/git/docs/git-svn.html).

And if you want to see a great example of a git-svn workflow in action, check out Jérémie Laval's blog post - [Working on Mono with git-svn](http://blog.neteril.org/2010/03/02/working-on-mono-with-git-svn/).
