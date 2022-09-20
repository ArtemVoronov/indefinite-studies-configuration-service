# How to build and run
 - For docker-compose create appropriate `.env` file at the root of project, e.g [.env.dev.dockercompose](https://github.com/ArtemVoronov/indefinite-studies-configruation-service/blob/main/.env.dev.dockercompose) and then `docker-compose up`
 - for k8s go to the section `Create k8s cluster`


# Creating self signed certs

## 1. Go `configs/tls` dir and edit `server-ext.cnf` if needs

## 2. Generate CA's private key and self-signed certificate

```
openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"

echo "CA's self-signed certificate"
openssl x509 -in ca-cert.pem -noout -text
```

## 3. Generate web server's private key and certificate signing request (CSR)

```
openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"
```

## 4. Use CA's private key to sign web server's CSR and get back the signed certificate

```
openssl x509 -req -in server-req.pem -days 360 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

echo "Server's signed certificate"
openssl x509 -in server-cert.pem -noout -text
```

# Create k8s cluster

```
TODO
```