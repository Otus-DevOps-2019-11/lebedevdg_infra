#!/bin/sh

cd /home/appuser

git clone -b monolith https://github.com/express42/reddit.git >/dev/null 2>&1

cd reddit && bundle install >/dev/null

puma -d >/dev/null

echo ""
ps aux | grep "puma" | grep -v -q grep && echo "\033[2;32;40m Puma is Running \033[0m" || echo "\033[41m Puma Stopped \033[0m" && echo ""
