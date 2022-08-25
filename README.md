# How to build and run
1. Create appropriate `.env` file at the root of project, e.g.:
```
#reqired for nginx
HOST_AUTH_SERIVCE=192.168.0.18
PORT_AUTH_SERIVCE=10000
HOST_PROFILES_SERIVCE=192.168.0.18
PORT_PROFILES_SERIVCE=10002
HOST_POSTS_SERIVCE=192.168.0.18
PORT_POSTS_SERIVCE=10004
```
2. `docker-compose build && docker-compose up`