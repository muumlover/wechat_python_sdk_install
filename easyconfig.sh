#!/usr/bin/env bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin
export PATH
#=================================================================#
#   System Required:  CentOS 6,7, Debian, Ubuntu                  #
#   Description: One click Install wechat-python-sdk              #
#   Author: muumlover <muumlover@foxmail.com>                     #
#   Intro:  https://muumlover.com                                 #
#=================================================================#

# Install Wechat
install(){
    wget --no-check-certificate https://raw.githubusercontent.com/muumlover/wechat_python_sdk_install/master/easyinstall.sh
    chmod +x easyinstall.sh
    ./easyinstall.sh 2>&1 | tee easyinstall.log
}

# Setup Wechat
setup(){
    # Set Project Name
    echo -e "Please enter a name for project:"
    read -p "(Default project name: project1):" PROJECT_NAME
    [ -z "${PROJECT_NAME}" ] && PROJECT_NAME="project1"

    # Set Application Name
    echo -e "Please enter a name for application :"
    read -p "(Default application name: app1):" APP_NAME
    [ -z "${APP_NAME}" ] && APP_NAME="app1"

    # Set Host Name
    echo -e "Please enter a host name :"
    read -p "(Default host name: example.com):" HOST_NAME
    [ -z "${HOST_NAME}" ] && HOST_NAME="*"

    django-admin.py startproject ${PROJECT_NAME}
    cd PROJECT_NAME
    python manage.py startapp ${APP_NAME}
    python manage.py makemigrations
    python manage.py migrate
    
    sed -i "/urlpatterns = /ifrom ${APP_NAME} import views\n" ${PROJECT_NAME}/urls.py
    sed -i "/urlpatterns = /a\    path('wechat/', views.wechat_home)," ${PROJECT_NAME}/urls.py
    
    #config hostname
    sed -i "/ALLOWED_HOSTS = /cALLOWED_HOSTS = ['${HOST_NAME}']" ${PROJECT_NAME}/settings.py 
    
    #setup views.py
    rm ${APP_NAME}/views.py 
    wget https://raw.githubusercontent.com/muumlover/wechat_python_sdk_install/master/views.py ${APP_NAME}/views.py 
}

# Start Wechat
start(){
    sudo python manage.py runserver 0.0.0.0:80 &  
}


