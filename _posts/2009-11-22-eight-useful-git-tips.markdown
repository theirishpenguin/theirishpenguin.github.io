---
comments: true
date: 2009-11-22 13:35:36
layout: post
slug: eight-useful-git-tips
title: Eight Useful Git Tips
wordpress_id: 381
tags:
- Programming
- RubyIreland
- UbuntuIreland
---
Here goes...

1. You can check your config using `git config -l`

   This tells you useful stuff like what remotes you're bound to, etc.

2. You can blow away files listed as 'untracked' (by the `git status` command) using `git clean` (be careful!).

   If you want any of those files to hang around (but not appear as 'untracked') then add them to your `.gitignore` file.

3. You can re-enter your last commit using `git commit --amend`. What's nifty is that you can change files (including file addition and deletion) as well as the commit message. Just do what you gotta do before running the amend command and enter a replacement commit message.

4. You can undo your last commit completely using `git reset HEAD^`

   Note: This does not change the working tree.

   Alternatively, you can use the syntax `git HEAD~2` instead of `HEAD^^`

5. Refer to the last revision by `HEAD`, the second last as `HEAD^` and the third last as `HEAD^^`

   You can keep adding carrets forever! Sounding like Bugs Bunny there.

6. You can see the contents of a file from a revision using

       git show rev:path/to/file

7. Ok, this tip is a bit of a longer one. Use `git merge some_other_branch` to merge another branch into the one your working on. (Note that `git pull` does a merge automatically once it's completely - if you don't want this to happen use `git fetch`). There are a few possible outcomes:

   Fast-forward merge : If changes were made on only one of the branches since the last merge, then the merge should happen without any need for you to act.

   Three-way merge: If changes were made on both branches, then git decides how to merge them using an algorithm. If any changes conflict with each other, then git will report them and let you resolve them. Once you've fixed any conflicts then you can `git commit`

   If there were no conflicts, git automatically does a commit with a stock commit message for the log. If you don't like the idea of this then use `git merge --no-commit some_other_branch` You need to manually do the commit afterwards. (This is more like how other distributed VCS's such as Mercurial. This was the tip that inspired this post!).

8. Finally, one tip that I found useful is that you don't want to `git pull` into your repository when you have uncommitted changes. Especially if you treasure your sanity. Instead `git stash` is your friend. Here's how
   * Do a `git stash` to move your uncommitted changes to a magical place in git temporarily
   * Then do the `git pull`
   * And finally do a `git stash apply` This will now move your 'stashed' uncommitted changes back (from the magical temporary place in git) into your working directory and take into account what what was changed by the pull. Neat!

   Tips 1-7 taken from:  [Git - SVN Crash Course](http://git.or.cz/course/svn.html). Tip 8 taken from painful experience :-)

   If you want a good detailed yet friendly reference on a particular command search the [Git User Manual](http://www.kernel.org/pub/software/scm/git/docs/user-manual.html) on kernel.org.
