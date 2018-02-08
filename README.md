# How to create sdkbox sample

Steps:

~~~bash
mkdir samples
cd samples

# must clone this repo
git clone --depth 1 https://github.com/sdkbox/sdkbox-cocos2d-x-binary.git

# unzip the large lib >= 100M (libcocos2d\ iOS.a)
unzip prebuilt/ios/libcocos2d\ iOS.a.zip -d prebuilt/ios/

# create facebook sample
./sdkbox-cocos2d-x-binary/create_project.sh facebook
~~~

# How to run sdkbox samples

Steps:

~~~bash
mkdir samples
cd samples

# must clone this repo
git clone --depth 1 https://github.com/sdkbox/sdkbox-cocos2d-x-binary.git

# get facebook sample
git clone --depth 1 https://github.com/sdkbox/sdkbox-sample-facebook.git

# run sample with specified language and platform
# eg: cpp and ios
./sdkbox-cocos2d-x-binary/run_sample.sh facebook cpp ios
# javascript and android
./sdkbox-cocos2d-x-binary/run_sample.sh facebook js android

~~~

Memo:

1.  All sample projects must be in same level directories

~~~
+-- sdkbox-cocos2d-x-binary
+-- sdkbox-sample-facebook
| +-- cpp
| +-- lua
| \-- js
+-- sdkbox-sample-fyber
+-- sdkbox-sample-appodeal
+-- <more>
~~~

# Make sure CCLOG write logs to lldb

### cocos/base/CCConsole.h

from:

~~~cpp
void CC_DLL log(const char * format, ...) CC_FORMAT_PRINTF(1, 2);
~~~

to:

~~~cpp
#if (CC_TARGET_PLATFORM != CC_PLATFORM_IOS)
void CC_DLL log(const char * format, ...) CC_FORMAT_PRINTF(1, 2);
#else
void CC_DLL log(const char * format, ...);
#endif
~~~


### cocos/base/CCConsole.cpp

from:

~~~cpp
void log(const char * format, ...)
{
    va_list args;
    va_start(args, format);
    _log(format, args);
    va_end(args);
}
~~~

to:

~~~cpp
#if (CC_TARGET_PLATFORM != CC_PLATFORM_IOS)
void log(const char * format, ...)
{
    va_list args;
    va_start(args, format);
    _log(format, args);
    va_end(args);
}
#endif
~~~


### platform/ios/CCCommon-ios.mm

add:

~~~cpp
void log(const char * format, ...)
{
    va_list args;
    va_start(args,format);
    NSLogv([NSString stringWithUTF8String:format], args) ;
    va_end(args);
}
~~~

<br/>

# install and run iOS app on device

~~~bash
set PROJECT_NAME=facebook_cpp
set CONFIGURATION=Debug

# choose language
cd cpp

# build
xcodebuild -target $PROJECT_NAME-mobile \
    -configuration $CONFIGURATION \
    -project proj.ios_mac/$PROJECT_NAME.xcodeproj

# install and run .app on device
ios-deploy --noninteractive --debug \
    --bundle proj.ios_mac/build/$CONFIGURATION-iphoneos/$PROJECT_NAME-mobile.app
~~~

- ios-deploy: [https://github.com/phonegap/ios-deploy](https://github.com/phonegap/ios-deploy)
- build it, copy `ios-deploy` to `/usr/local/bin`

