#!/bin/bash

firewall-cmd --zone=public --add-port=9200/tcp --permanent
firewall-cmd --zone=public --add-port=9300/tcp --permanent
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

yum install -y elasticsearch 

cat <<EOF >>/etc/elasticsearch/elasticsearch.yml
cluster.name: cluster$(hostname | awk -Fuser '{print $2}')
network.host: 0.0.0.0
discovery.seed_hosts: ["${HOSTNAME}"]
cluster.initial_master_nodes:  ["${HOSTNAME}"]
#discovery.seed_hosts: ["es01-$(hostname | awk -F- '{print $2}')", "es02-$(hostname | awk -F- '{print $2}')", "es03-$(hostname | awk -F- '{print $2}')"]
#cluster.initial_master_nodes: ["es01-$(hostname | awk -F- '{print $2}')", "es02-$(hostname | awk -F- '{print $2}')", "es03-$(hostname | awk -F- '{print $2}')"]
EOF

systemctl daemon-reload
#systemctl enable elasticsearch
#systemctl start elasticsearch
