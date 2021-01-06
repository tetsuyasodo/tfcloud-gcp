#!/bin/bash
setenforce 0

yum update -y
yum install -y httpd
systemctl start httpd
cat <<EOF >/var/www/html/index.html
<HTML><BODY>
<h1>Hello world.</h1>
</BODY></HTML>
EOF
