#!/bin/bash

firewall-cmd --zone=public --add-port=5044/tcp --permanent
firewall-cmd --zone=public --add-port=9600/tcp --permanent
firewall-cmd --reload

yum update -y

cat <<'EOF' >/etc/yum.repos.d/elastic.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

yum install -y java-11-openjdk-devel logstash

systemctl daemon-reload
#systemctl enable logstash
#systemctl start logstash
