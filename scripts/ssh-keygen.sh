#!/bin/bash

for i in $(seq -f%02g 1 10); do
	ssh-keygen -N '' -f ~/.ssh/id_rsa-user$i
	cp ~/.ssh/id_rsa-user$i.pub ../pubkeys/
done
