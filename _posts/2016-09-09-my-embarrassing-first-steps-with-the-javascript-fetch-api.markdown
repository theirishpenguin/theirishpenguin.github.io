---
comments: true
date: 2016-09-09 23:57:12
layout: post
slug: my-embarrassing-first-steps-with-the-javascript-fetch-api
title: My Embarrassing First Steps with the Javascript fetch() API
wordpress_id: 1052
highlight: false
image: https://upload.wikimedia.org/wikipedia/commons/7/73/Javascript-736400_960_720.png
tags:
- javascript
---

<b>Spoiler: If you are more interested in the destination than the journey
then skip to the last code example in this article.</b>
So after a decade of the dollar, the great $ symbol that is ubiquitously
associated with jQuery (and mostly AJAX), we're finally moving on. Moving
on to what promises to be a leaner, more modern
API in the shape of fetch(). My motivation came from
[this post](https://github.com/reactjs/redux/issues/723#issuecomment-139927639)
about waiting for multiple async calls in Redux. I'd been using jQuery (or a layer on top
of jQuery such as Backbone) to talk to remote servers since
James Blunt hit the charts with "You're Beautiful". And since moving
to React it didn't seem to make much sense to pull in all of jQuery just
to make a few simple remote calls - so trusting in Dan Abramov (has he
ever put a foot wrong?!) I decided to polyfill in fetch() and friends,
and embrace the simplicity of this new standard. Trouble is, it's not as
straightforward to get started as you might think it is.

<figure style="float: right; margin:20px;">

<a title="By JavaScript,Pixabay (pixabay.com) [CC BY 4.0
(http://creativecommons.org/licenses/by/4.0)], via Wikimedia Commons"
href="https://commons.wikimedia.org/wiki/File%3AJavascript-736400_960_720.png"><img
width="256" alt="Javascript-736400 960 720"
src="https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Javascript-736400_960_720.png/256px-Javascript-736400_960_720.png"/></a>

</figure>

First up, my understanding of promises is fairly
rudimentary - basically they are a fancy way of returning a function
that will be called at some point in the future, and can handle a happy
code path and a sad code path. I'd read that jQuery's way of doing promises
(deferreds) "are a bit… unhelpful". And that you should [cast them to
standard promises, which is worth doing as soon as possible](http://www.html5rocks.com/en/tutorials/es6/promises/),
. So I had an immediate
distrust of jQuery's deferreds from what I had read and was ready to go
all in on the shiny new fetch() API to ensure that I was using the most
standard version of promises that bitcoins can buy. By this point
we're really up for doing the fetch() thing correctly.

 
The first hit on Google for "fetch javascipt" is the
Mozilla Development Network's article on the Fetch API and from here it
is a short hop to the [Using Fetch
article](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch).
So I rushed to the first example, which is

    var myImage = document.querySelector('img');

    fetch('flowers.jpg')
    .then(function(response) {
      return response.blob();
    })
    .then(function(myBlob) {
      var objectURL = URL.createObjectURL(myBlob);
      myImage.src = objectURL;
    });

and wrote the equivalent code (slightly ES6-ified) that I needed which was...

    fetch('my-json-serving-url')
    .then(response => {
      debugger
      //return response.blob();
    })

I got rid of the second then() because I figured my use case is simpler than
theirs. And I figured that if I could drop myself into the Chrome
debugger I could work out the appropriate method on the response
object to get whatever I needed out. It was all looking familiar and
simple, just like it said on the tin.

So I got to my breakpoint and I saw a friendly ```text()``` method available
as well as a ```json()``` method. And indeed I called them - and
frustratingly got the following back in my JS console...

    [[PromiseStatus]] : "resolved"
    [[PromiseValue]] : undefined

So I googled around for "pending status fetch promise" and the first hit
was [StackOverflow](http://stackoverflow.com/questions/30329485/why-is-the-promise-still-pending) -
trusting in StackOverflow (have they ever put a foot wrong?!) I
clicked through to question but saw the answer didn't look quite as relevant to me
as I'd hoped. So I moved along - along to lots of articles like
[this](https://github.com/w3c/ServiceWorker/issues/625), which sounded
very complicated for the "Hello World!" of the fetch() world that I was
trying to piece together, so I gave up. I knew that there was
new-fangled streaming stuff in the new fetch() and I must be tripping up
on that - might be best to read about that on my aging Nexus phone on
the commute home.

As I was closing down the hundreds of tabs I had opened about fetch() - one by one - like a
roadie taking down marquees at the end of a music festival, I paused
before X-ing
the tab where it had all
[started](https://github.com/reactjs/redux/issues/723#issuecomment-139927639).
It occurred to me that instead of going for the cheapest item in the
shop, I should probably try the second cheapest. I'll
try two then() calls one after the other.


    fetch('my-json-serving-url')
    .then(response => {
      return response.json();
    })
    .then(responseBody => {
      debugger
      // oh responseBody, just please have something in you that isn't pending!
    })

Boom! Like a green light at the end of a unit test there was finally
something tangible in the responseBody argument. Encouraged by this I
could now make sense of more of the original Mozilla Developer Network
[page](https://developer.mozilla.org/en-US/docs/Web/API/Fetch_API/Using_Fetch),
in particular their Checking For Success example...

    fetch('flowers.jpg').then(function(response) {
      if(response.ok) {
        response.blob().then(function(myBlob) {
          var objectURL = URL.createObjectURL(myBlob);
          myImage.src = objectURL;
        });
      } else {
        console.log('Network response was not ok.');
      }
    })
    .catch(function(error) {
      console.log('There has been a problem with your fetch operation: ' +
    error.message);
    });

I didn't give a monkey's for checking for success in my embryonic
attempt at calling fetch() earlier. But now I could see that I could do
the chaining all in one...

    fetch('my-json-serving-url')
    .then(response => {
      response.json().then(responseBody => {
        debugger
        console.log(responseBody)
        // Go'on the responseBody, ya beauty!
      })
    })

The ES5 equivalent is something like...

    fetch('my-json-serving-url')
    .then(function(response){
      response.json().then(function(responseBody){
        console.log(responseBody)
      })
    })

Call it perceptual narrowing when my initial attempt went pear-shaped,
or call it laziness, or stupidity. Whatever it was, that was one long journey towards
calling fetch(). Anyway, I hope someone else finds this useful and
doesn't have to travel around the Internet a dozen times to ditch the
dollar and fire off a fetch().

<i>Title Image Attribution: "By JavaScript",Pixabay (pixabay.com) [CC BY 4.0 (http://creativecommons.org/licenses/by/4.0)], via Wikimedia Commons</i>
