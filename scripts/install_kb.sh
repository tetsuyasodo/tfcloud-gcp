#!/bin/bash

firewall-cmd --zone=public --add-port=5601/tcp --permanent
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

yum install -y kibana

cat <<EOF >>/etc/kibana/kibana.yml
server.host: "0.0.0.0"
elasticsearch.hosts: ["http://es01-$(hostname | awk -F- '{print $2}'):9200"]
#elasticsearch.hosts: ["http://es01-$(hostname | awk -F- '{print $2}'):9200", "http://es02-$(hostname | awk -F- '{print $2}'):9200", "http://es03-$(hostname | awk -F- '{print $2}'):9200"]
EOF

systemctl daemon-reload
#systemctl enable kibana
#systemctl start kibana
