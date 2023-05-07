#!/bin/sh

dcleanup(){
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

indefclean() {
    version="${1:-0.01}"
    echo "version is ${version}"
    docker rmi indefinite-studies-web-ui:${version}
    docker rmi indefinite-studies-subscriptions-service:${version}
    docker rmi indefinite-studies-notifications-service:${version}
    docker rmi indefinite-studies-feed-builder-service:${version}
    docker rmi indefinite-studies-posts-service-liquibase:${version}
    docker rmi indefinite-studies-posts-service:${version}
    docker rmi indefinite-studies-profiles-service-liquibase:${version}
    docker rmi indefinite-studies-profiles-service:${version}
    docker rmi indefinite-studies-auth-service-liquibase:${version}
    docker rmi indefinite-studies-auth-service:${version}
}

indefbuild() {
    version=${1:-0.01}
    echo "version is ${version}"
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    docker build -t indefinite-studies-auth-service:$version			"${pathToProjectsRoot}/indefinite-studies-auth-service"
    docker build -t indefinite-studies-auth-service-liquibase:$version 		"${pathToProjectsRoot}/indefinite-studies-auth-service/docker/liquibase/"
    docker build -t indefinite-studies-profiles-service:$version		"${pathToProjectsRoot}/indefinite-studies-profiles-service"
    docker build -t indefinite-studies-profiles-service-liquibase:$version 	"${pathToProjectsRoot}/indefinite-studies-profiles-service/docker/liquibase/"
    docker build -t indefinite-studies-posts-service:$version			"${pathToProjectsRoot}/indefinite-studies-posts-service"
    docker build -t indefinite-studies-posts-service-liquibase:$version		"${pathToProjectsRoot}/indefinite-studies-posts-service/docker/liquibase/"
    docker build -t indefinite-studies-feed-builder-service:$version		"${pathToProjectsRoot}/indefinite-studies-feed-builder-service"
    docker build -t indefinite-studies-subscriptions-service:$version		"${pathToProjectsRoot}/indefinite-studies-subscriptions-service"
    docker build -t indefinite-studies-notifications-service:$version		"${pathToProjectsRoot}/indefinite-studies-notifications-service"
    docker build -t indefinite-studies-web-ui:$version				"${pathToProjectsRoot}/indefinite-studies-web-ui"
}

indefload() {
    version="${1:-0.01}"
    echo "version is ${version}"
    minikube image load indefinite-studies-auth-service:${version}
    minikube image load indefinite-studies-auth-service-liquibase:${version}
    minikube image load indefinite-studies-profiles-service:${version}
    minikube image load indefinite-studies-profiles-service-liquibase:${version}
    minikube image load indefinite-studies-posts-service:${version}
    minikube image load indefinite-studies-posts-service-liquibase:${version}
    minikube image load indefinite-studies-feed-builder-service:${version}
    minikube image load indefinite-studies-notifications-service:${version}
    minikube image load indefinite-studies-subscriptions-service:${version}
    minikube image load indefinite-studies-web-ui:${version}
}

indefconfig() {
    type=${1:-kube}
    configType=""
    if [ $type = "kube" ]; then
        configType=".env.dev.kube"
	echo "KUBE!"
    else
        configType=".env.dev.dockercompose"
	echo "DOCK!"
    fi
    echo "configType is ${configType}"
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    cp "${pathToProjectsRoot}/indefinite-studies-auth-service/${configType}"		"${pathToProjectsRoot}/indefinite-studies-auth-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-profiles-service/${configType}"	"${pathToProjectsRoot}/indefinite-studies-profiles-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-posts-service/${configType}"		"${pathToProjectsRoot}/indefinite-studies-posts-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-feed-builder-service/${configType}"	"${pathToProjectsRoot}/indefinite-studies-feed-builder-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-subscriptions-service/${configType}"	"${pathToProjectsRoot}/indefinite-studies-subscriptions-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-notifications-service/${configType}"	"${pathToProjectsRoot}/indefinite-studies-notifications-service/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-web-ui/${configType}"			"${pathToProjectsRoot}/indefinite-studies-web-ui/.env"
    cp "${pathToProjectsRoot}/indefinite-studies-configuration-service/${configType}"	"${pathToProjectsRoot}/indefinite-studies-configuration-service/.env"
}

indefbackdown() {
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-auth-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-profiles-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-posts-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-feed-builder-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-subscriptions-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-notifications-service/docker-compose.yml" down
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-configuration-service/docker-compose.yml" down
}

indefbackpurge() {
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    ${pathToProjectsRoot}/indefinite-studies-auth-service/run.sh purge
    ${pathToProjectsRoot}/indefinite-studies-profiles-service/run.sh purge
    ${pathToProjectsRoot}/indefinite-studies-posts-service/run.sh purge
    ${pathToProjectsRoot}/indefinite-studies-feed-builder-service/run.sh purge
    ${pathToProjectsRoot}/indefinite-studies-subscriptions-service/run.sh purge
    ${pathToProjectsRoot}/indefinite-studies-notifications-service/run.sh purge
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-configuration-service/docker-compose.yml" down
}

indefbackup() {
    indefconfig "dock"
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-auth-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-profiles-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-posts-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-feed-builder-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-subscriptions-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-notifications-service/docker-compose.yml" up -d
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-configuration-service/docker-compose.yml" up -d
}

indefbackbuild() {
    indefconfig "dock"
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-auth-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-profiles-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-posts-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-feed-builder-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-subscriptions-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-notifications-service/docker-compose.yml" build
    docker-compose -f "${pathToProjectsRoot}/indefinite-studies-configuration-service/docker-compose.yml" build
}

indefping() {
    curl http://localhost/api/v1/auth/ping
    curl http://localhost/api/v1/users/ping
    curl http://localhost/api/v1/posts/ping
    curl http://localhost/api/v1/feed/ping
    curl http://localhost/api/v1/notifications/ping
    curl http://localhost/api/v1/subscriptions/ping
    echo "\n"
}

indefcerts() {
    pathToProjectsRoot=/home/voronov/projects/my/indefinite-studies
    cd "${pathToProjectsRoot}/indefinite-studies-configuration-service/configs/tls"
    openssl req -x509 -newkey rsa:4096 -days 365 -nodes -keyout ca-key.pem -out ca-cert.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"
    openssl req -newkey rsa:4096 -nodes -keyout server-key.pem -out server-req.pem -subj "/C=RU/ST=/L=/O=/OU=/CN=*.indefinite-studies.ru/emailAddress=voronov54@gmail.com"
    openssl x509 -req -in server-req.pem -days 360 -CA ca-cert.pem -CAkey ca-key.pem -CAcreateserial -out server-cert.pem -extfile server-ext.cnf

    local serviceNames
    getServiceNames serviceNames

    for serviceName in "${serviceNames[@]}"
    do
        rm -rv "${pathToProjectsRoot}/${serviceName}/configs/tls"
        mkdir -p "${pathToProjectsRoot}/${serviceName}/configs/tls"
        cp -r "${pathToProjectsRoot}/indefinite-studies-configuration-service/configs/tls" "${pathToProjectsRoot}/${serviceName}/configs/"
    done
}

case "$1" in
  start)
    indefbackdown
    indefbackbuild
    indefbackup
    ;;
  stop)
    indefbackdown
    ;;
  purge)
    indefbackpurge
    ;;
  update_certs)
    indefcerts
    ;;
  *)
    echo "Usage: $0 {start|stop|purge|update_certs}"
esac