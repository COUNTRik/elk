#!/usr/bin/env bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Установим нужные нам пакеты
yum install -y mc vim wget

yum install -y epel-release
yum install -y nginx

systemctl start nginx
systemctl enable nginx

# Копируем публичный ключ репозитория elasticsearch
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Копируем файлы репозитория elasticsearch и kibana
cp /vagrant/config/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo

# Установим filebeat
yum install -y filebeat auditbeat

# Включим неохродимые модули в filebet
filebeat modules enable system
filebeat modules enable nginx
