#!/bin/sh

apt-get update >/dev/null && apt-get install -y ruby-full ruby-bundler build-essential >/dev/null

echo ""
ruby -v | grep -i -q "ruby" && echo  "\033[2;32;40m Ruby Installed \033[0m" || echo "\033[41m FAIL! \033[0m" && echo ""
bundler -v |grep -i -q "Bundler" && echo  "\033[2;32;40m Bundler Installed \033[0m" || echo "\033[41m FAIL! \033[0m" && echo ""
