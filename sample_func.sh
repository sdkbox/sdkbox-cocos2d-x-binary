#!/bin/bash
COCOS_ROOT_DIR=$(cd "$(dirname $0)" && pwd)
cd $COCOS_ROOT_DIR
cd ..
WORKING_DIR=`pwd`

echo -e "\033[33mCOCOS_ROOT_DIR\033[0m"
echo $COCOS_ROOT_DIR
echo ""

echo -e "\033[33mWORKING_DIR\033[0m"
echo $WORKING_DIR
echo ""
