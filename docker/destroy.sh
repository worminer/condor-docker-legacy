#!/bin/bash
set -e
 
docker-compose down --volumes
#docker rmi webapp_apache-service webapp_php-service webapp_mysql-service