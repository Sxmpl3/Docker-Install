#!/bin/bash

yum install -y docker
systemctl start docker
systemctl enable docker
yum install -y docker-compose

cat <<EOF > docker-compose.yml
version: '3.7'
services:
  wordpress:
    image: wordpress
    ports:
      - "80:80"
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: my_password
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress:/var/www/html
  db:
    image: mysql:5.7
    environment:
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: my_password
      MYSQL_ROOT_PASSWORD: my_root_password
    volumes:
      - db:/var/lib/mysql
volumes:
  wordpress:
  db:
EOF

sudo docker-compose up -d
