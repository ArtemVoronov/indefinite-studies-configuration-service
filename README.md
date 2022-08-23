# How to build and run
1. Create appropriate `.env` file at the root of project, e.g.:
```
#reqired for nginx
#reqired for nginx
HOST_PROFILES_SERIVCE=192.168.0.18
PORT_PROFILES_SERIVCE=81
HOST_AUTH_SERIVCE=192.168.0.18
PORT_AUTH_SERIVCE=82
HOST_POSTS_SERIVCE=192.168.0.18
PORT_POSTS_SERIVCE=83
```
2. `docker-compose build && docker-compose up`