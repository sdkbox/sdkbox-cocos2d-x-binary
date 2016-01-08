# How to run sdkbox samples

Steps:

~~~bash
mkdir samples
cd samples

git clone https://github.com/sdkbox/sdkbox-cocos2d-x-3.9-binary.git
git clone https://github.com/sdkbox/sdkbox-sample-facebook.git

./sdkbox-cocos2d-x-3.9-binary/run_sample.sh facebook cpp ios
~~~

Memo:

1.  All sample projects must be in same level directories

~~~
+-- sdkbox-cocos2d-x-3.9-binary
+-- sdkbox-sample-facebook
| +-- cpp
| +-- lua
| \-- js
+-- sdkbox-sample-fyber
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

