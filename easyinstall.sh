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

echo
echo "#############################################################"
echo "# Install System Update                                     #"
echo "#############################################################"
echo
yum -y update

echo
echo "#############################################################"
echo "# Install Python Support                                    #"
echo "#############################################################"
echo
yum -y groupinstall "Development tools"
yum -y install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel
yum -y install gcc libffi-devel python-devel openssl-devel

echo
echo "#############################################################"
echo "# Install Python3.4                                         #"
echo "#############################################################"
echo
yum -y install epel-release
yum -y install python34
yum -y install python-devel.x86_64

echo
echo "#############################################################"
echo "# Install&Update Pip                                        #"
echo "#############################################################"
echo
yum -y install python-pip
pip install --upgrade pip

echo
echo "#############################################################"
echo "# ReLink System Python Version                              #"
echo "#############################################################"
echo
rm /usr/bin/python
ln -s python3 /usr/bin/python

echo
echo "#############################################################"
echo "# Fix Yum For Old Python Version                            #"
echo "#############################################################"
echo
sed -i '1d' /usr/bin/yum 
sed -i '1i\#!/usr/bin/python2' /usr/bin/yum
sed -i '1d' /usr/libexec/urlgrabber-ext-down
sed -i '1i\#!/usr/bin/python2' /usr/libexec/urlgrabber-ext-down

echo
echo "#############################################################"
echo "# Install&Update Pip For Python3                            #"
echo "#############################################################"
echo
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm ./get-pip.py

echo
echo "#############################################################"
echo "# Install Django                                            #"
echo "#############################################################"
echo
pip install Django

echo
echo "#############################################################"
echo "# Install wechat-sdk                                        #"
echo "#############################################################"
echo
pip install wechat-sdk

clear
echo
echo "#############################################################"
echo "# wechat-python-sdk Install Success!!!                      #"
echo "#############################################################"
echo
