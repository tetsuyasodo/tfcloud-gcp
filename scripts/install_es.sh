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

# 3 Node Cluster setting
#discovery.seed_hosts: ["es01-$(hostname | awk -F- '{print $2}')", "es02-$(hostname | awk -F- '{print $2}')", "es03-$(hostname | awk -F- '{print $2}')"]
#cluster.initial_master_nodes: ["es01-$(hostname | awk -F- '{print $2}')", "es02-$(hostname | awk -F- '{print $2}')", "es03-$(hostname | awk -F- '{print $2}')"]

# Security setting
#xpack.security.enabled: true

# Transport layer encryption setting
#xpack.security.transport.ssl.enabled: true
#xpack.security.transport.ssl.verification_mode: certificate
#xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
#xpack.security.transport.ssl.truststore.path: elastic-certificates.p12
EOF

yum install -y wget
wget https://github.com/tetsuyasodo/tfcloud-gcp/raw/main/scripts/elastic-certificates.p12 -O /etc/elasticsearch/elastic-certificates.p12
chown root:elasticsearch /etc/elasticsearch/elastic-certificates.p12
chmod 660 /etc/elasticsearch/elastic-certificates.p12

systemctl daemon-reload
#systemctl enable elasticsearch
#systemctl start elasticsearch
