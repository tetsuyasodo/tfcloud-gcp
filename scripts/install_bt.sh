#!/bin/bash

firewall-cmd --zone=public --add-port=5066/tcp --permanent
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

yum install -y filebeat metricbeat

systemctl daemon-reload
#systemctl enable filebeat
#systemctl start filebeat
#systemctl enable metricbeat
#systemctl start metricbeat
