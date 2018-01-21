#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================================#
#   System Required:  CentOS 6,7, Debian, Ubuntu                  #
#   Description: One click Install wechat-python-sdk              #
#   Author: muumlover <muumlover@foxmail.com>                     #
#   Intro:  https://muumlover.com                                 #
#=================================================================#

clear
echo
echo "#############################################################"
echo "# One click Install wechat-python-sdk                       #"
echo "# Intro: https://muumlover.com                              #"
echo "# Author: muumlover                                         #"
echo "# Github: https://github.com/muumlover                      #"
echo "#############################################################"
echo

yum update
yum groupinstall "Development tools"
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
yum install epel-release
yum install python34
yum install python-pip

pip install --upgrade pip

rm /usr/bin/python
ln -s python3 /usr/bin/python

sed -i '1d' /usr/bin/yum 
sed -i '1i\#!/usr/bin/python2' /usr/bin/yum

pip install Django

pip install wechat-sdk
