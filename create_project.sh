#!/bin/bash
CUR_DIR=$(cd "$(dirname $0)" && pwd)

if [ "$1" == "" ]; then
	echo "create_projects.sh project_name"
	echo ""
	exit
fi

PARENT_DIR=$(cd .. && pwd)
COCOS_BIN=${CUR_DIR}/tools/cocos2d-console/bin/cocos
SDKBOX_BIN=${PARENT_DIR}/sdkbox-installer/sdkbox

PROJECT_NAME=$1
PLUGIN_NAME=$2

if [ "$PLUGIN_NAME" == "" ]; then
	PLUGIN_NAME=$PROJECT_NAME
fi

cd "$PARENT_DIR"
mkdir sdkbox-sample-${PROJECT_NAME}
cd sdkbox-sample-${PROJECT_NAME}
PROJECT_DIR=`pwd`

# cpp
${COCOS_BIN} new -l cpp -t binary -p com.sdkbox.sample.${PROJECT_NAME}.cpp --portrait ${PROJECT_NAME}_cpp
mv ${PROJECT_NAME}_cpp cpp

cd cpp
${SDKBOX_BIN} import $PLUGIN_NAME
rm backup-*.zip

cp .sdkbox_packages.json .sdkbox_packages.json_
sed s/jars/libs/ < .sdkbox_packages.json_ > .sdkbox_packages.json
rm .sdkbox_packages.json_

cd proj.android
cp project.properties project.properties_
sed s/jars/libs/ < project.properties_ > project.properties
rm project.properties_

mv jars/* libs
rmdir jars
find libs -type d | grep "bin" | xargs rm -f $1
find libs -type d | grep "gen" | xargs rm -f $1

# lua
cd "$PROJECT_DIR"

${COCOS_BIN} new -l lua -t binary -p com.sdkbox.sample.${PROJECT_NAME}.lua --portrait ${PROJECT_NAME}_lua
mv ${PROJECT_NAME}_lua lua

cd lua
${SDKBOX_BIN} import $PLUGIN_NAME
rm backup-*.zip

cp .sdkbox_packages.json .sdkbox_packages.json_
sed s/jars/libs/ < .sdkbox_packages.json_ > .sdkbox_packages.json
rm .sdkbox_packages.json_

cd frameworks/runtime-src/proj.android
cp project.properties project.properties_
sed s/jars/libs/ < project.properties_ > project.properties
rm project.properties_

mv jars/* libs
rmdir jars
find libs -type d | grep "bin" | xargs rm -f $1
find libs -type d | grep "gen" | xargs rm -f $1


# js
cd "$PROJECT_DIR"

${COCOS_BIN} new -l js -t binary -p com.sdkbox.sample.${PROJECT_NAME}.js --portrait ${PROJECT_NAME}_js
mv ${PROJECT_NAME}_js js

cd js
${SDKBOX_BIN} import $PLUGIN_NAME
rm backup-*.zip

cp .sdkbox_packages.json .sdkbox_packages.json_
sed s/jars/libs/ < .sdkbox_packages.json_ > .sdkbox_packages.json
rm .sdkbox_packages.json_

cd frameworks/runtime-src/proj.android
cp project.properties project.properties_
sed s/jars/libs/ < project.properties_ > project.properties
rm project.properties_

mv jars/* libs
rmdir jars
find libs -type d | grep "bin" | xargs rm -f $1
find libs -type d | grep "gen" | xargs rm -f $1


# git
cd "$PROJECT_DIR"
git init .
git config user.name tinybearc
git config user.email tinybearc@gmail.com
git config credential.https://github.com/sdkbox/sdkbox-sample-${PROJECT_NAME}.git tinybearc

git add -f .
sed s/PLUGIN/${PLUGIN_NAME}/ < ${CUR_DIR}/gitignore_tpl > .gitignore
git add -f .gitignore
git commit -m "init import"
git remote add origin https://github.com/sdkbox/sdkbox-sample-${PROJECT_NAME}.git
git push -u origin master
