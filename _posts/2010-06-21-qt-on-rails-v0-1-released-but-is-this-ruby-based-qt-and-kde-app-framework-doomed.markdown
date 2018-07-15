---
comments: true
date: 2010-06-21 05:00:24
layout: post
slug: qt-on-rails-v0-1-released-but-is-this-ruby-based-qt-and-kde-app-framework-doomed
title: Qt on Rails v0.1 released. But is this Ruby-based Qt and KDE app framework
  doomed?
wordpress_id: 550
tags:
- Geek
- kde
- Linux
- Programming
- RubyIreland
- Rubyonrails
- Ubuntu
- UbuntuIreland
- desktop
- framework
- kde
- kubuntu
- maemo
- qt
- rails
- ruby
---

Ruby has changed the way developers build web applications. Since popularised by the Rails framework, programmers no longer stumble around in the dark with disparate web forms; instead they are able to clearly focus on the business problem and expose a well-modelled domain in a easily testable manner. Traditionally used in data-heavy domains, today's web apps now encroach on the desktop's home turf of rich highly-functional applications - something years ago thought impossible. And most surprisingly, through clever use of patterns and conventions, they've arguably become the easier of the two to develop. Given this, could desktop developers learn from the web app approach? This is in part the motivation behind Qt on Rails - let's use a conventions-based approach to building desktop applications and clients. Let's harness the ease and expressiveness of the Ruby language. And let's have a clean consistent domain model underneath the hood with a comprehensive suite of tests to boot. A grand idea; but right now, it's on course to fail...

![](/assets/images/disc_jockey_list.png)

**Main window listing Disc Jockeys (Click the image to enlarge)**


### What does this framework look like?

What exactly is Qt on Rails? Well first, let me just make a little guilty admission. This blog post is aimed at Ruby and/or Rails developers first, then Qt/KDE developers second. This is not because I believe one camp is more important than the other. It is because I really want to bring Rails dev's on-board to KDE/Qt development and I see a real need to give them a first-class Qt toolkit; to make desktop apps as brilliant and easy to develop as their web apps. If Qt on Rails ever makes it as far as being a fully mature framework, I hope that a Rails developer using it for the first time will find it a very familiar experience. The directory structure, naming conventions and overall architecture (to date at least) has been chosen to that end. But I hope to do an article focusing on approaching this project from a more on Qt/KDE perspective. So what is Qt on Rails like?

Well, imagine you just wrote a Rails web application. You're finished! Let's say we just built a web app for a fictional company called RAD Radio. We have two important things in our system - Disc Jockeys and Sponsors for the radio shows. So we have this really neat model layer sitting on top of our database. It handles all our business logic and things like validation of data being persisted - let's reuse this... verbatim! This is our line in the sand! Design choice 1, Qt on Rails literally reuses everything from the model layer down already within your Rails application!

If we start from the front end of our proposed desktop application and work backwards, we want to have a Qt app which consists of various different screens, some of which may be on display simultaneously. This is a little different from the web, because generally on the web you can think of having just one screen and this gets blown away on each request (unless AJAX intervenes, but still you get the overall point). In a Qt desktop app we decide that our initial screen is to be "main" window for our application. Clicking on a button may cause a new window to launch, for example, a window to edit a Disc Jockey's details, but the main window will remain there, though not active. This kind of difference (from your typical web behaviour) presents a difficult challenge and will have a big effect on our architecture - for example, it has influenced my decision not to try and reuse anything for the controller layer generated in a Rail's application. Back to our story, we have a main window as our starting point, which you can see in the figure above. It should have a way to navigate between different parts of your application. This is achieved through the big command link buttons at the top of the window. In our web application, each part of our application is based on different sources of data (called resources when using RESTful terminology). Clicking on the Sponsors command link button would cause the grid to be refreshed with Sponsor records. And then clicking on the Disc Jockeys command link button refresh the grid with Disc Jockey records again.


> This sounds reasonable so far. A quick side note though; bear in mind this is still early days for Qt on Rails. I'm sure many good KDE and Qt developers may be horrified at the UI decisions made above. I'm not a Qt or KDE expert! This is another big challenge. One of the most crucial areas we need help on is getting feedback on how Qt and KDE applications are generally laid out, what widgets are used for what purposes and so on. In essence, what are the best practice guidelines for [HCI](http://en.wikipedia.org/wiki/Human%E2%80%93computer_interaction) in something like KDE and how can we incorporate that into the apps we generate with Qt on Rails.


So we are looking at the main window, which contains a list of Disc Jockeys in a grid - how does this work? Well, first we need to be aware of what Qt is giving us here. The list widget that you see on screen is a Qt widget called a QTableView. It is concerned only with displaying stuff. Underneath that we have a QAbstractTableModel. This holds the data, it does not care about how it will be displayed. Now it's worth pointing out that a QAbstractTableModel has nothing to do with the Rails concept of a model. You see, the Qt folks have used the MVC pattern in their architecture for [donkey's years](http://en.wiktionary.org/wiki/donkey%27s_years) now; and it's important to not confuse the two different uses of the same paradigm. The QAbstractTableModel is an object into which you stick a whole bunch of Rails records that you wish to display in a list. We then plug the QAbstractTableModel into the QTableView widget and that's how your records are displayed. It's also important to note that when a QTableView sees the QAbstractTableModel being plugged in - it has absolutely no idea that the underlying records are of type Disc Jockey. Think of the QAbstractTableModel as an adapter between a collection of records for a particular Rails model and the QTableView widget which will ultimately display them. Probably most importantly, remember that

* A Rail's model equates to one record
	
* Whereas a QAbstractTableModel equates to many records - it sits on top of a collection of Rails records and allows them to be displayed in something like a QTableView widget

> Note: The Qt API is incredible. It's extremely comprehensive! Check it out at [http://doc.qt.nokia.com](http://doc.qt.nokia.com) You will want to look at the "C++ Application Development Framework" for the version of Qt you develop with. One big tip to note down - where it talks about something like a QAbstractTableModel in the docs - is that it is referring to the C++ world. In your head just translate this to Qt::TableModel - now you can happily use all the documentation available. Also, in your code you will always write Qt::AbstractTableModel, never QAbstractTableModel.

So to edit a Disc Jockey record I select a row and click the Edit button near the bottom of the page. Hey presto! An Edit Disc Jockey form appears...

![Edit Form - Disc Jockey](/assets/images/edit_disc_jockey_form.png)
**Form for editing a Disc Jockey (Click the image to enlarge)**

Nice! And when you click the Save button the Edit form is dismissed and the list of Disc Jockeys in our main window is refreshed!

Cool! But where do all the Qt on Rails files live?

Qt on Rails is installed in the vendor/plugins directory of your Rails app (see [http://github.com/theirishpenguin/qtonrails](http://github.com/theirishpenguin/qtonrails) for more details on how to install). Under vendor/plugins/qtonrails/ there is a directory called app/ which holds the Qt application code. In turn, app/ is divided into the following subdirectories, with each subdirectory corresponding to a layer in our application framework, listed here from the highest level (like the HTML stuff in a web app) to the lowest (the controller in our case - as everything from models down to db is handled by vanilla Rails).
	
* **qdesigns** - XML markup files (with a .ui extension) which are to Qt screens/widgets what HTML files are to HTML pages/elements

* **ui_proxies** - A Ruby representation of .ui files - this is an autogenerated layer which you don't really need to worry about
	
* **qpresenters** - Where the presentation logic (not any business logic) for your screen lives
	
* **qhelpers** - A place to put logic that you wish to reuse across presenters
	
* **qviews** - Where we decide exactly how we will build a view for a particular controller action (I accept that the name 'qviews' is confusing; maybe 'qviewbuilders' would be better or something totally different)

* **qcontrollers** - Where we decide what data to retrieve for a particular action (though we don't specify 'where to go' in the way a Rails controller has render() or redirect_to() methods)

### I am the Executioner...

So here's the flow of control. In our vender/plugins/qtonrails directory we have a 'run' command. When we execute it, the command...
	
1. Fires up a Qt Application instance

2. Asks our (very primitive) Router to take a given route and instantiate a QView and a QController for it

3. The QController then fetches data depending on the action (just like a Rails action) and hands off the data to the QView

4. The QView then decides what screen should be build (or whether to stay on the same screen and perhaps just refresh a list of records)

5. Once the appropriate Screen has been built, it is displayed with a show() call. At this point the user will then see something happen on-screen.

The above is pretty much like one request-response cycle in a Rails app. Now we play the waiting game
	
* The user does something like selects a row and clicks the Edit button.

* At this point the QPresenter comes into play. The QPresenter **is** your window widget. I didn't tell you then, but the QPresenter was created earlier in the QView layer when we call the constructor for the window (ie. the QPresenter) we wish to display). I'm open to the fact that QPresenter may not be the best name for this! Anyway, the QPresenter contains your presentation logic. In our case, the user has just clicked the Edit button on the MainWindow presenter. This causes the handler for the event - the edit_clicked() slot to be called. Qt uses a brilliant concept called Signals and Slots to handle events in your application - a Signal is something that acts as a trigger (such as a button being clicked) for a Slot; a Slot simply being a function dedicated to doing something useful in response. A Signal is connected to a Slot using the aptly named connect() method. I neglected to bore you with this little detail earlier but this connection was carried out in the constructor for the QPresenter (ie. the window) which took place a few steps back when we mentioned that the QView layer decided what screen is to be built

* Finally, the slot - edit_clicked() in this case - asks the Router to take a given route and now we're back to step 2 of the flow of control outlined earlier

* Phew!

### Make it so, Jim!

So that's it in a nutshell. How do get all this lovely goodness to turn your Rails web app into a skeleton desktop app? One command, mon ami! From the root of your Rails directory simply run

    ./script/generate qtify DiscJockey Sponsor

So let's say you have no Rails app right now. Here's how to get to a basic web app and skeleton desktop app in double quick time!

> Firstly, just a quick note on OS dependencies. Qt on Rails has mainly been developed to date on Kubuntu 9.04, Kubuntu 9.10 and the Ubuntu Netbook Remix 9.10. For these platforms, you can install the packages mentioned in the "First Install the appropriate packages" section of this [Developing Qt4 Applications using Qt Designer and Ruby on Kubuntu](http://techbase.kde.org/Development/Tutorials/Developing_Qt4_Applications_using_Qt_Designer_and_Ruby_on_Kubuntu) article, which also goes into more detail on QtRuby development if you're interested. This [QtRuby bindings article](http://techbase.kde.org/Development/Languages/Ruby) on the KDE TechBase also gives some useful info on the Ruby bindings for Qt.

> We've not tried this yet on Windows or Mac, but here's a [Windows QtRuby install guide](http://vision.eng.shu.ac.uk/mmvlwiki/index.php/Qt4-QtRuby_installer_for_Microsoft_Windows) by Richard Dale and a [QtRuby on the Mac install guide](http://osake.wordpress.com/2009/08/21/qt4-qtruby-mac-os-x/). So you are welcome to try and install QtRuby on one of these platforms but we can't promise anything!

> Perhaps, most excitingly of all, Qt on Rails apps can be deployed to Maemo devices such as the N900! Check out this related [Deploying your Qt on Rails apps on the N900 (Maemo)](http://www.theirishpenguin.com/2010/06/21/deploying-your-qt-on-rails-apps-on-the-n900-maemo/) article! And MeeGo support will surely follow sometime soon!

Ok, let's cook you up a Rails app. Here we are using Rails 2.3.5 and assuming you are at a Linux command line (see [Qt on Rails github project](http://github.com/theirishpenguin/qtonrails) page for more installation details of Qt on Rails itself)...

    rails RadRadio
    cd RadRadio
    ./script/plugin install git://github.com/theirishpenguin/qtonrails.git
    ./script/generate scaffold DiscJockey name:string date_of_birth:date programme_name:string radio_slot:time max_num_guests:integer next_review:datetime
    ./script/generate scaffold Sponsors name:string signed_up_on:date
    rake db:migrate
    ./script/generate qtify DiscJockey Sponsor
    cd vendor/plugins/qtonrails
    ./run
    # If ./run on it's own gave you a permission error you can try 'ruby ./run' instead
    # Oh yeah!

### What you see is almost what you get...

Hopefully, you should be seeing an app around about now. Once you have some rows in the list of disc jockeys or sponsors (create some DJs using the New button), you will see that cells of the grid that make up the list can be edited in-place. This is quite a powerful feature to have out of the box. An Edit button is provided also, though if you plan to provide an Edit button to your users, which launches a form, then you should probably make the grid read-only so as not to confuse them by having two ways of editing. As this is a early prototype of the framework, I've left the Edit button and in-place editing enabled, trusting you to tailor them to your app's needs. If you were going to switch off in-place editing you would probably also want to select the entire row (rather than just one cell) when you click on a cell in the row.

Let's have a quick look at form validation in action. Add a validates_presence_of validator to your DiscJockey and Sponsor Rails models so that they look as follows

    #In app/models/disc_jockey.rb (under root of your Rails app, not under qtonrails)
    
    class DiscJockey < ActiveRecord::Base
        validates_presence_of :name
    end
    
    #In app/models/sponsor.rb (under root of your Rails app, not under qtonrails)
    
    class Sponsor < ActiveRecord::Base
        validates_presence_of :name
    end

Close and restart the RadRadio Qt on Rails app. When you hit the New button and try to create a new Disc Jockey or Sponsor without a name, you will see that the Rails model validation kicks in and you get a validation message telling you that you need to correct the name field. Validation also works if you are editing a record after clicking the Edit button, however validation messages don't appear if you edit a record in-place in the grid (just because I haven't had a chance to implement that yet).

Again, as it's an early release there's also plenty of bugs in there, such as a crash if you try to click the Edit Button without selecting any row. A list of issues is maintained on the [Qt on Rails Issue Tracker](http://github.com/theirishpenguin/qtonrails/issues). Check it out to see what limitations currently exist and add to it if you spot a new problem!

### Doomed?

As you can see, this codebase is being opened up quite early. A good start has been made - but the project is still very embryonic! Surely, it's a bit early to be talking about doom? Well, unless hacking on Qt on Rails appeals to some developers out there it will certainly die a merry death on the great scrapheap of nice projects that just didn't make it. Why? Not only is there a lot of work that needs to be done, but also it's more fun to work on the project when there's a crew involved, which also brings new ideas and energy to any project. Otherwise it's unsustainable.

But life wouldn't be fun it it wasn't a bit of a challenge, **right**? If you think this kind of project might interest you, if you're not put off by insurmountable odds, then **know that your framework needs you!** Drop me an email at declan \[\[AT\]\] weuseopensource \[\[DOT\]\] com or twit a quick tweet on twitter (theirishpenguin). The [Qt on Rails Issue Tracker](http://github.com/theirishpenguin/qtonrails/issues) is a good place to start looking for things to hack on. Or you're welcome to fork the project on github and develop that killer feature you'd like to see in there!

Qt on Rails, because it's at an early stage, is an easy place to start - there isn't lots of code to weigh you down. The framework itself is very thin, the majority of the code is actually Rails style generators to take the Rails model layer and build the Qt/KDE app on top of it. Because of the tiny codebase, it shouldn't be hard too get your head around what's going on.

### Qt on Rails doesn't want to be doomed!

It's intended that Qt on Rails gives Ruby and/or Rails developers an outlet to develop first class desktop apps using the best available framework. Rails developers often ask, "If I want to build a great cross-platform desktop app, what GUI toolkit would I use?" The answer varies and there no one headline GUI toolkit/desktop framework that currently has mindshare amongst Ruby developers and works great across multiple platforms. Given that Qt is currently so strong across the Linux desktop, commercial Windows applications, Macs and mobile platforms such as Maemo and MeeGo why shouldn't it be the first thing you reach for when building a Ruby desktop app? Come help us build Qt on Rails! **Stave off the doom!**
