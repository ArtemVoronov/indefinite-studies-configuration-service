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
HOST_FEED_BUILDER_SERIVCE=192.168.0.18
PORT_FEED_BUILDER_SERIVCE=10006
HOST_WEB_UI=192.168.0.18
PORT_WEB_UI=3000
```
2. `docker-compose build && docker-compose up`

# Creating self signed certs

## 1. Generate CA's private key and self-signed certificate
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text

## 2. Generate web server's private key and certificate signing request (CSR)
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"

## 3. Use CA's private key to sign web server's CSR and get back the signed certificate
openssl x509 -req -in server-req.pem -days 360 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text