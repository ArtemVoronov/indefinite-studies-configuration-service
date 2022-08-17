# How to build and run
1. Set environment vars in the config `.env` e.g.:
```
#reqired for nginx
HOST_PROFILES_SERIVCE=192.168.0.18
PORT_PROFILES_SERIVCE=81
HOST_AUTH_SERIVCE=192.168.0.18
PORT_AUTH_SERIVCE=82
```
2. Check `docker-compose.yml` is appropriate to config that you are going to use (e.g.`docker-compose config`)
3. Build images: `docker-compose build`
4. Run it: `docker-compose up`
5. Stop it: `docker-compose down`