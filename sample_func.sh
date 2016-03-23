#!/bin/bash
COCOS_ROOT_DIR=$(cd "$(dirname $0)" && pwd)
cd $COCOS_ROOT_DIR
cd ..
WORKING_DIR=`pwd`
COCOS_BIN=$COCOS_ROOT_DIR/tools/cocos2d-console/bin/cocos

echo -e "\033[33mCOCOS_ROOT_DIR\033[0m"
echo $COCOS_ROOT_DIR
echo ""

echo -e "\033[33mWORKING_DIR\033[0m"
echo $WORKING_DIR
echo ""

function cleanupSample()
{
    cd "$SAMPLE_ROOT_DIR"
    git reset --hard master
    git clean -dfx
    git pull origin master
}

function updateSample()
{
    cd "$SAMPLE_ROOT_DIR"
    cd $PROJECT_LANG
    sdkbox update
}

function updateStagingSample()
{
    cd "$SAMPLE_ROOT_DIR"
    cd $PROJECT_LANG
    sdkbox update --staging
}

function buildIOS()
{
    echo -e "\033[33mBuild for iOS\033[0m"

    if [ "$PROJECT_LANG" == "cpp" ]; then
        PROJECT_ROOT_DIR=proj.ios_mac
    else
        PROJECT_ROOT_DIR=frameworks/runtime-src/proj.ios_mac
    fi

    xcodebuild -target ${PROJECT_NAME}_${PROJECT_LANG}-mobile \
        -configuration Debug \
        -project ${PROJECT_ROOT_DIR}/${PROJECT_NAME}_${PROJECT_LANG}.xcodeproj
}

function runIOS()
{
    echo -e "\033[33mInstall and run on iOS device\033[0m"

    if [ "$PROJECT_LANG" == "cpp" ]; then
        PROJECT_ROOT_DIR=proj.ios_mac
    else
        PROJECT_ROOT_DIR=frameworks/runtime-src/proj.ios_mac
    fi

    ios-deploy --noninteractive --debug \
        --bundle ${PROJECT_ROOT_DIR}/build/Debug-iphoneos/${PROJECT_NAME}_${PROJECT_LANG}-mobile.app
}

function buildAndroid()
{
    echo -e "\033[33mBuild for Android\033[0m"

    $COCOS_BIN compile -m debug -p android

    echo ""
    echo ""

    if [ "$PROJECT_LANG" == "cpp" ]; then
        APK_OUTPUT_DIR=bin/debug/android
    else
        APK_OUTPUT_DIR=simulator/android
    fi

    ls -lh $APK_OUTPUT_DIR

    echo ""
    echo ""
}

function runAndroid()
{
    echo -e "\033[33mInstall and run on Android device\033[0m"

    if [ "$PROJECT_LANG" == "cpp" ]; then
        APK_OUTPUT_DIR=bin/debug/android
    else
        APK_OUTPUT_DIR=simulator/android
    fi

    if [ "$PACKAGE_NAME" == "" ]; then
        PACKAGE_NAME="com.sdkbox.sample.${PROJECT_NAME}.${PROJECT_LANG}"
    fi

    adb wait-for-device
    adb uninstall ${PACKAGE_NAME}
    adb install -rtdg ${APK_OUTPUT_DIR}/${PROJECT_NAME}_${PROJECT_LANG}-debug.apk

    echo ""
    echo ""

    PACKAGE_SUFFIX=$PROJECT_LANG
    if [ "$PROJECT_LANG" == "js" ]; then
        PACKAGE_SUFFIX=javascript
    fi

    adb shell am start -n ${PACKAGE_NAME}/org.cocos2dx.${PACKAGE_SUFFIX}.AppActivity |
    {
        ERROR=0
        while read line
        do
            echo $line
            if [[ "$line" =~ "Error" ]]; then
                ERROR=1
            fi
        done
        if [ $ERROR != 0 ]; then
            exit
        fi
    }

    adb shell ps | grep ${PACKAGE_NAME} |
    {
        while read line
        do
            set $line
        done

        PID=$2
        if [ "$PID" != "" ]; then
            echo ""
            echo -e "\033[33mCheck log ...\033[0m"
            echo ""
            adb logcat | grep "\(${PID}\)"
        else
            echo ""
            echo -e "\033[33mPlease check error messages, or unlock your device ...\033[0m"
            echo ""
        fi
    }
}
