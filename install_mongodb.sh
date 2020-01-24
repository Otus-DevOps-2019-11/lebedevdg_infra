#!/bin/sh

apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xd68fa50fea312927 > /dev/null 2>&1
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" > /etc/apt/sources.list.d/mongodb-org-3.2.list

echo ""

apt-get update >/dev/null && apt-get install -y mongodb-org >/dev/null && systemctl start mongod  && systemctl enable mongod && echo "\033[2;32;40m Installed \033[0m" || echo "\033[41m FAIL \033[0m" && echo ""

systemctl status mongod | grep -q "enabled;" && echo  "\033[2;32;40m Mongo Enabled \033[0m" || echo "\033[41m Mongo Disabled! \033[0m" && echo ""
systemctl status mongod | grep -q "active (running)" && echo "\033[2;32;40m Mongo is Running \033[0m" || echo "\033[41m Mongo Stopped! \033[0m" && echo ""
