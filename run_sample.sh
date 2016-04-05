#!/bin/bash
CUR_DIR=$(cd "$(dirname $0)" && pwd)
source "$CUR_DIR"/sample_func.sh

function help()
{
    echo "run_sample.sh PROJECT_NAME PROJECT_LANG PLATFORM [options] [PACKAGE_NAME]"
    echo ""
    echo "options:"
    echo "    --reset cleanup project"
    echo "    --update run sdkbox update"
    echo "    --update-staging run sdkbox update --staging"
    echo ""
    echo "examples:"
    echo "    run_sample.sh facebook lua ios"
    echo "    run_sample.sh appodeal cpp android org.cocos2dx.appodeal"
    echo "    run_sample.sh appodeal cpp android --reset-staging org.cocos2dx.appodeal"
    echo ""
}

# init

if [ "$3" == "" ]; then
    help
    exit
fi

PROJECT_NAME=$1
PROJECT_LANG=$2
PLATFORM=$3

PACKAGE_NAME=""
UPDATE=""
COMPILE_ONLY=
RESET=

while [ "$4" != "" ]; do
    if [ "$4" == "--update" ]; then
        UPDATE='--update'
    elif [ "$4" == "--update-staging" ]; then
        UPDATE='--update-staging'
    elif [ "$4" == "--reset" ]; then
        RESET="--reset"
    elif [ "$4" == "--compile-only" ]; then
        COMPILE_ONLY="--compile-only"
    else
        PACKAGE_NAME=$4
    fi

    shift
done

if [ "$PACKAGE_NAME" == "" ]; then
    PACKAGE_NAME="com.sdkbox.sample.${PROJECT_NAME}.${PROJECT_LANG}"
fi

echo "PROJECT_NAME = $PROJECT_NAME"
echo "PROJECT_LANG = $PROJECT_LANG"
echo "PLATFORM     = $PLATFORM"
echo "PACKAGE_NAME = $PACKAGE_NAME"
echo "UPDATE       = $UPDATE"
echo "COMPILE_ONLY = $COMPILE_ONLY"
echo "RESET        = $RESET"
echo ""
echo ""

SAMPLE_ROOT_DIR=${WORKING_DIR}/sdkbox-sample-${PROJECT_NAME}

if [ ! -d "$SAMPLE_ROOT_DIR" ]; then
    echo "ERR: not found sample dir $SAMPLE_ROOT_DIR"
    echo ""
    help
    exit
fi

cd $SAMPLE_ROOT_DIR

if [ ! -d "$PROJECT_LANG" ]; then
    echo "ERR: not found sample project dir ${SAMPLE_ROOT_DIR}/${PROJECT_LANG}"
    echo ""
    help
    exit
fi

echo -e "\033[33mSAMPLE_ROOT_DIR\033[0m"
pwd

cd $PROJECT_LANG
pwd
echo ""

if [ "$UPDATE" == "--update" ]; then
    cleanupSample
    updateSample
fi

if [ "$UPDATE" == "--update-staging" ]; then
    cleanupSample
    updateStagingSample
fi

if [ "$RESET" == "--reset" ]; then
    cleanupSample
fi

if [ "$PLATFORM" == "ios" ]; then
    buildIOS
    if [ "$COMPILE_ONLY" != "--compile-only" ]; then
        runIOS
    fi
elif [ "$PLATFORM" == "android" ]; then
    buildAndroid
    if [ "$COMPILE_ONLY" != "--compile-only" ]; then
        runAndroid
    fi
fi

