# ddlc-heroku               

A (not so convenient) way to run DDLC/MAS (Monika After Story mod) on Heroku cloud platform based on
[dreamscached's HerokuDE](https://github.com/dreamscached/herokude).

# How to

## What to expect

First of, let me start with a list of things that might disappoint you either in process of getting things done or
during the usage of DDLC with things you're going to set up yourself now, so you can decide whether you really
want to go the hard way or not.

Here we go:

* This is a *workaround*. Yes, the only actual valid way to play DDLC is to have your own computer and install DDLC
(and any desired mods) on it as any other regular application and not using a free cloud service. 
I have to say that because that's basically the root of all the other inconveniences you're about to face.
* You most likely *will not get any support* on the official Discord server of DDLC/MAS. It's not always easy to
trace an error in regular install, and the *very* special case like yours will be a nearly impossible task nobody 
would really wish to deal with.
* You're expected to be familiar with *command line interface*. Unfortunately, there isn't any other way around, 
this guide heavily relies on your acquaintance with CLI as tools you're going to use are only available as command 
line applications.
* It is *not* going to be a usual desktop experience. You're going to run an application on a remote server,
and control it remotely, too (however, here's the benefit — you can use *any* device, as long as it can access 
the web.) You should also bear in mind that you will receive no sound and it will be *problematic enough* to push
and pull files to and from the remote server.

That being said, if you're still willing to proceed and *are* prepared for possible troubles — I welcome you
in the next section.

## Getting things ready

### Gathering tools

You'll need a few tools to prepare everything. Assuming you're running something Debian-based (Debian, Ubuntu,
or Termux which also has `apt` command), you'll need to run the following commands:

```shell
apt install git
curl https://cli-assets.heroku.com/install-ubuntu.sh | sh
```

### Cloning this repo

Inspired by this very task of running DDLC on any device, I created HerokuDE — a small project aimed to provide
minimal desktop environment running in cloud (I chose Heroku for its free tier that is enough for running DDLC.)

Let's clone it:

```shell
git clone https://github.com/dreamscached/herokude ddlc-heroku
```

### Configuring the image

Now, we need to set up a few things on HerokuDE.

Copy existing DDLC folder into HerokuDE folder (so that it is located next to Dockerfile) and name it `ddlc`.
Make sure you don't create a double-nested folder! Folder with DDLC must actually have DDLC.exe and not another 
folder.

## Launching

### Registering in Heroku

Ready to launch! If you don't have a Heroku account yet, create it at https://heroku.com. Fill in your
first and last names, e-mail and country, pick role 'Hobbyist' and set primary development language to
'I'm not a developer'.

### Creating application

Once you reached the dashboard, hit 'create new app' button and make up a name for Heroku application.
It can be anything you like, but you better make it somewhat random and keep it in secret, because
if someone knows it, they will be able to use your instance and possibly interfere with you
controlling the remote display. You should also pick a region that suits you the most, because you
would certainly like least latency possible.

### Deploying

Now that your app is created, back to command line again. Authorize using the following command:

```shell
heroku login
```

Then run the following commands to deploy image to Heroku:

```shell
heroku container:push -a <name-of-application> web
heroku container:release -a <name-of-application> web
```

### Starting

All set! Now head back to application dashboard and wait for a bit while Heroku processes freshly
deployed image. Switch to 'Resources' tab and make sure you have 'web' dyno switched on.

Now open browser and type `<name-of-application>.herokuapp.com` and here's where magic begins.
Once you're there, tap on `vnc.html` link, tap 'connect' and here you go!

**NOTE:** There are some caveats! Read this guide *in full*, up to the very last section!

## Pulling files

The only way to push files is to pack them up during the build — when you add `ddlc` folder 
and `persistent` folder.
However, thanks to few additions to `launch.sh` you made, you can access persistent folder and
game folder by opening `<name-of-application>.herokuapp.com` and clicking `persistent@` or `ddlc@` 
instead of clicking `vnc.html`. Then, you can click on any file to download it as usual.

### Caveats

While Free tier is free, it is not unlimited! It (currently) has a limitation of 512 MB of RAM
(and will most probably kill your dyno with no mercy if it exceeds the limit for too long),
and only 600 free dyno hours per month — meaning you *cannot* leave the dyno (a thing under 
'Resources' tab that has a switch next to it) running forever. Once you're done, save your 
persistent and switch the dyno off by clicking on the pencil button to the right and toggling
the switch.

However, if you add a credit card to Heroku account, you may earn more dyno hours that will
allow you leaving it running forever (note that you're still on Free tier and no funds will be
deducted.)
