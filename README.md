
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
