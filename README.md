# VPN

Установлка и настройка ELK для сбора логов NGINX.

Запустим стенд с двумя машинами *log* и *web*. Все нужные пакеты установятся через vagrant.

## Настройка Elasticsearch

Примечаение: по-умолчанию Elasticsearch слушает все имеющиеся сетевые интерфейсы. В файле */etc/elasticsearch/elasticsearch.yml* желательно добавить параметр *network.host: 127.0.0.1*

## Настрйка Kibana

Добавляем параметр *server.host: "192.168.50.10"*

## Настройка Logstash

Создаем конфигурационные файлы для logstash в */etc/logstash/conf.d/*. Примеры input.conf (параметры приемы информации), nginx-filter.conf (фильтрация логов nginx), system-filter.conf (фильтрация системных логов), output.conf (параметры отправки информации) находятся в папке *config*, они будут скопированы при запуске vagrant.

## Найстройка Filebeat

Немного изменим конфигурационный файл */etc/filebeat/filebeat.yml* на машине *web*.

Так как мы будем использовать Logstash для дополнительной обработки данных, Filebeat не потребуется отправлять данные в Elasticsearch напрямую, поэтому мы отключим этот вывод. Для этого мы найдем раздел output.elasticsearch и закоментируем этот параметр в 

	#output.elasticsearch:
	  # Array of hosts to connect to.
	  #hosts: ["localhost:9200"]

И раскомментируем раздел output.logstash указав ip нашего лог сервера.

	output.logstash:
	  # The Logstash hosts
	  hosts: ["192.168.50.10:5044"]

Также необходимо включить необходимые нам модули командой

	filebeat modules enable system

	filebeat modules enable nginx

Запускаем *filebeat*

	# systemctl enable filebeat
	# systemctl start filebeat


## Запуск ELK

Запускаем стек ELK на *log*

	# systemctl daemon-reload

	# systemctl enable elasticsearch
	# systemctl start elasticsearch

	# systemctl enable kibana
	# systemctl start kibana

	# systemctl enable logstash
	# systemctl start logstash