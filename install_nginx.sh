#!/bin/bash
apt update
apt install -y nginx
cat <<EOF >/var/www/html/index.html
<HTML><BODY>
<h1>Hello world.<h1>
</BODY></HTML>
EOF
