---
comments: true
date: 2010-09-26 21:02:14
layout: post
slug: accessing-your-encrypted-home-directory-in-ubuntu
title: Accessing your encrypted home directory in Ubuntu
wordpress_id: 915
tags:
- Linux
- Ubuntu
- UbuntuIreland
- encryption
- kubuntu
- mount
- opensuse
- Ubuntu
---

This process details accessing an home directory, which was encrypted using the "encrypted ~/Private directory" technique, that has been with us since Ubuntu 8.10 (Intrepid Ibex) and available as an install option.

This took a lot longer than expected in terms of sifting through information. Here I detailed what worked for me. I used the guide on [Recovering your Data Manually](https://help.ubuntu.com/community/EncryptedPrivateDirectory#Recovering%20Your%20Data%20Manually) as the foundation.

**Note: I tried to carry out this process using OpenSuse 11.2 but was unsuccessful.** Here's some notes regarding my OpenSuse attempt

* The package name of the encryption utility is the same on OpenSuse 11.2, so you can use `zypper install ecryptfs-utils`
	
* The syntax of the `ecryptfs-add-passphrase` seemed to be different as it didn't have a `--fnek` option

* I suspect the problem is that the ecryptfs utility that comes with OpenSuse 11.2 doesn't support file name encryption. I found that I could decrypt the files and directories, view their contents but the file and directory names were all mangled

Ok, meanwhile back at the ranch, we're trying to access an encrypted Ubuntu home directory from another partition, in my case a Kubuntu installation. When reading this guide be aware that there are two passphrases mentioned - a login passphrase (the usual password you use to login to your computer) and a mount passphrase (a big long jumble of characters that is vital to decrypting your partition). Later in the guide we also mention the sudo password - this is the password you type to get full superuser privileges on your machine. Here we go...

### Step 1: Getting the all-important mount passphrase

First, we need the **mount passphrase** that was generated when you first installed Ubuntu with the directory encrypted (or whenever you manually encrypted the directory, if you didn't do so during installation). If you were diligent at time of encryption you have written this down somewhere. For the rest of us :-), log into the Ubuntu containing the encrypted home directory and run the command,

`ecryptfs-unwrap-passphrase /home/.ecryptfs/ubuntu_user/.ecryptfs/wrapped-passphrase`

Then type in your login passphrase (it's the one that you usually type to login into your computer) when prompted in order to reveal the mount passphrase (the big jumble of characters). Record the mount passphrase somewhere as you'll need it later.

**I can't help you if you don't have your the mount passphrase or are unable to log into the Ubuntu containing the encrypted home directory which you are trying to access.**


### Step 2: Accessing the encrypted home directory from another O.S.

Log into the other O.S., as I said, in my case a Kubuntu installation.
	
* Ensure that you have the encryption utilities installed

      sudo apt-get install ecryptfs-utils
	
* Browse to the encrypted home directory on the other partition using your file manager in order to mount it. I used Dolphin on Kubuntu to browse to `/media/disk-3/home`
	
  * If you have found the correct directory you should see 2 files `Access-Your-Private-Data.desktop` and `README.txt`
	
  * We will need this directory later
	
* From the command line, navigate to your normal home directory on Kubuntu
	
      cd /home/kubuntu_user
	
* Create a directory in which we can mount the encrypted home directory
	
      mkdir OtherHome
	
* We need to get a special signature that will be used later for decrypting filenames (you can skip this step if you are trying to access Ubuntu 8.10 or less I think)
	
      sudo ecryptfs-add-passphrase --fnek
	
  Note: first you will need to enter your sudo password and then the mount passphrase
	
  Pay attention to the second `"Inserted auth tok with sig"` line and note down the value in square brackets (eg. 66a9f67af69a86aa) as we will need this signature later

* Here's the real magic, which decrypts the home directory on Ubuntu and accesses it via the OtherHome directory on Kubuntu.
Note: Carefully look at the command and change the `/media/disk-3/home/.ecryptfs/ubuntu_user/.Private/` bit to whatever is correct for you
	
      sudo mount -t ecryptfs /media/disk-3/home/.ecryptfs/ubuntu_user/.Private/ /home/kubuntu_user/OtherHome
	
  You will be asked a series of questions

  * Select passphrase as the key type
	
  * Enter the mount phrase when asked for the passphrase
	
  * Select aes as the ecryption cipher

  * Select 16 bytes as the key length
	
  * Enter n for enabling of plaintext passthrough

  * Enter y for filename encryption (if you obtained the special signature in the earlier step)

  * Enter the special signature from earlier when you are prompted for the Filename Encryption Key (FNEK) Signature

  * Note: You will get the following warning but there is no need to worry about it
	
        WARNING: Based on the contents of [/root/.ecryptfs/sig-cache.txt],
        it looks like you have never mounted with this key
        before. This could mean that you have typed your
        passphrase wrong

* If it worked then the very last line will be `Mounted eCryptfs`

You should now be able to navigate into `OtherHome` and access the files there. Hurrah!
