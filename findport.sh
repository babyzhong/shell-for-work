#!/bin/bash
#Author ZHH
#Find 'listen-port' depends on config.xml According to name of project (e.g. mainService)

#DH=
#Set DOMAIN_HOME of Weblogic
# --- Start Functions ---

noproject()
{
        echo "Need to set PROJECT_NAME"
        echo "Usage: $1 PROJECT_NAME"
        echo "for example:"
        echo "$1 mainService"
}

# --- End Functions ---

if [ "$1" = "" ] ;then
        noproject $0
        exit
fi

PROJECT_NAME=$1

CONFIG_FILE=`find $DH -name config.xml|xargs grep $PROJECT_NAME -A 1|grep -v bak|grep target|awk 'NR==1 {print $1}'|awk -F '-' '{print $1}'`
echo $CONFIG_FILE
if [ "$CONFIG_FILE" = "" ] ;then
        echo "Please recheck the name of project,there is no such package in the server"
        exit 1
fi

TARGET=`cat $CONFIG_FILE|grep $PROJECT_NAME -A 1|grep target|awk -F '>' '{print $2}'|awk -F '<' '{print $1}'`

echo $TARGET

PORT=`cat $CONFIG_FILE|grep $TARGET -A 15|grep '^    <listen-port'|awk 'NR==1 {print $1}'|awk -F '>' '{print $2}'|awk -F '<' '{print $1}'`
echo $PORT
