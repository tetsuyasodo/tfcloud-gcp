#!/bin/bash
setenforce 0
firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload
yum update -y
yum install -y httpd
systemctl start httpd
cat <<EOF >/var/www/html/index.html
<HTML><BODY>
<h1>Hello world.</h1>
</BODY></HTML>
EOF
