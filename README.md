# weblate-docker-fig
building a working Weblate docker environment

## Prerequisites
* docker
* fig

##Preparing

You have to checkout with submodules like:

```bash
git clone --recursive https://github.com/okaufmann/weblate-docker-docker-compose.git
```

**Otherwise it won't work!**

## Usage
```
$ cd weblate-docker-fig/run/weblate
$ docker-compose up
``` 

## Configuration
``` 
$ vi weblate-docker-fig/run/weblate/var/lib/weblate/settings_user.py
``` 
