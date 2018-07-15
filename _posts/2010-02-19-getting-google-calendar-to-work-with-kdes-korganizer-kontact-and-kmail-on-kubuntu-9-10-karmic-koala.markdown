---
comments: true
date: 2010-02-19 09:30:42
layout: post
slug: getting-google-calendar-to-work-with-kdes-korganizer-kontact-and-kmail-on-kubuntu-9-10-karmic-koala
title: Getting Google Calendar to work with KDE's KOrganizer, Kontact and KMail (on
  Kubuntu 9.10 Karmic Koala)
wordpress_id: 454
tags:
- General Computers
- kde
- Linux
- Ubuntu
- UbuntuIreland
- akonadi
- calender
- google
- kde
- kontact
- korganizer
- kubuntu
---

Woah! That's a lot of K's in the title! But it's all in the name of getting your calender talking to your desktop so it's for a good kause (sorry!)

There's this great package in KDE that has a really cool name called Akonadi (pronounced Ahh-Kon-ahh-dee if you want to impress your friends!). But more than just a cool name it does cool things - particularly in the realm of syncing data on your desktop with a remote server. Ooo yeah, including Google's servers. Akonadi is one of the 'pillars' of the KDE platform and here's how you can use that pillar to prop up your schedules and calendaring with KOrganizer-Google integration. It's easy on Kubuntu Karmic!

- Install the Google data package for Akonadi

      sudo apt-get install akonadi-kde-resource-googledata

- Ensure the Akonadi Tray Utility is running by performing the following steps

- Search for Akonadi in the search box of the Kickoff Launcher (KDE's "Start" menu). Click the Akonadi Tray Utility that is found

- Go to the tray on the bottom right of your beautiful KDE desktop and click the small arrow, if necessary, to to expand all the tray icons

- You should see an icon for Akonadi. Right click on it and select 'Start Akonadi'

- This should start the Akonadi server. You can verify this by right clicking the icon again and checking to see that there is now a 'Stop Akonadi' option

- Right click on the Akonadi icon yet again and select 'Configure'

- Under the Akonadi Resources configuration, click Add and elect to add a Google Calendar Data Resource

- Enter your login details for your google account

- Next it's off to Kontact. Go to the Calendar in Kontact

- There should be a small Calendar pane on the bottom right to set up calendar resources. Click the Plus sign to add an "Akonadi (Provides access to calendars stored in Akonadi calendar folders)"

- In the resulting popup, choose the google resource in the list and ensure that Events is ticked to the right of it. (I didn't try to get Todos or Journals working because I don't use them)

- Hey presto! All your calendar details should now be pulled into KOrganizers calendar! Hurrah!!!

Just to note, at time of writing I found that I had to search and find the Akonadi Tray Utility on restarting the computer. Once it's in the System Tray elect to start Akonadi as we did above and you're back in the game! If you find a solution to this minor inconvenience on restarting your machine then please post below!

Thanks to Christian Mangold for this [article](http://neversfelde.de/?p=5) which served as a great reference.
