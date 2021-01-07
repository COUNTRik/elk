#!/usr/bin/env bash

# Авторизуемся для получения root прав
mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh

# Установим нужные нам пакеты
yum install -y mc vim wget

# Копируем публичный ключ репозитория elasticsearch
rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

# Копируем файлы репозитория elasticsearch и kibana
cp /vagrant/config/elasticsearch.repo /etc/yum.repos.d/elasticsearch.repo
cp /vagrant/config/kibana.repo /etc/yum.repos.d/kibana.repo

# Устанавливаем elasticsearch logstash kibana
yum install -y elasticsearch logstash kibana

# Слушать только с локального интерфейса для elasticsearch
echo "network.host: 127.0.0.1" >> /etc/elasticsearch/elasticsearch.yml

# Слушать только с локального интерфейса
# echo "server.host: 192.168.50.10" >> /etc/kibana/kibana.yml

# Копируем конфиги logstash
cp /vagrant/config/input.conf /etc/logstash/conf.d/input.conf
cp /vagrant/config/nginx-filter.conf /etc/logstash/conf.d/nginx-filter.conf
cp /vagrant/config/system-filter.conf /etc/logstash/conf.d/system-filter.conf
cp /vagrant/config/output.conf /etc/logstash/conf.d/output.conf

# Запускаем стек ELK
# systemctl daemon-reload

# systemctl enable elasticsearch
# systemctl start elasticsearch

# systemctl enable kibana
# systemctl start kibana

# systemctl enable logstash
# systemctl start logstash