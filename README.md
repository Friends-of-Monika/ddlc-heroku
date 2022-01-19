# HerokuDE

This project is an attempt to run a (more or less) fully-featured desktop
environment in Heroku to be able to run applications in it.

Note however, even though this image was designed to work on Heroku, it also
works as standalone Docker image that you can run locally yourself.


## How does it work

Since Heroku [allows deployment of Docker images](https://devcenter.heroku.com/articles/build-docker-images-heroku-yml#heroku-yml-overview),
one could create an image with minimal window manager, VNC server
software and NoVNC as a way to use VNC in browser (due to Heroku restricting
open ports to HTTP/HTTPS only.)

Here, the following components are used:

* Xvfb for virtual display initialization
* Fluxbox as window manager
* X11VNC as VNC server


## Usage

### Deploying to Heroku

#### With Heroku CLI

```shell
$ heroku container:push -a <app-name> web
$ heroku container:release -a <app-name> web
```

#### With Heroku template

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy?template=https://github.com/dreamscached/herokude)


### Running locally

```shell
$ git clone https://github.com/dreamscached/herokude HerokuDE
$ docker build --rm -t herokude:ubuntu20.04 .
$ docker run --rm -d --name herokude -e PORT=80 -p 80:80 herokude:ubuntu20.04
```

## Configuration

Image has few environment variables you can use to somehow customize your
instance.

| Variable    | Default value        | Description                                                              |
|-------------|----------------------|--------------------------------------------------------------------------|
| GEOMETRY    | 1920x1080x16         | Defines screen geometry in format WIDTHxHEIGHTxDEPTH                     |
| PORT        | 8080                 | Defines port that NoVNC will listen to                                   |
| COMMANDLINE | bash /data/launch.sh | Defines command line to run upon initial setup of window manager and VNC |                    
