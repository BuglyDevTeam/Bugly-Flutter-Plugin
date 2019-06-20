#import "BuglyCrashPlugin.h"
#import <Bugly/Bugly.h>
#import <Bugly/BuglyLog.h>

@implementation BuglyCrashPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"bugly"
            binaryMessenger:[registrar messenger]];
  BuglyCrashPlugin* instance = [[BuglyCrashPlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"initCrashReport" isEqualToString:call.method]) {
    NSString *appId = call.arguments[@"appId"];
    BuglyConfig *config = [[BuglyConfig alloc] init];
    config.debugMode = YES;
    config.reportLogLevel = BuglyLogLevelVerbose;
    NSLog(@"initCrashReport appid:%@",appId);
    //[Bugly startWithAppId:appId];
    [Bugly startWithAppId:appId config:config];
  } else if ([@"postException" isEqualToString:call.method]) {
     NSLog(@"postException");
     NSString *type = call.arguments[@"type"];
     NSString *error = call.arguments[@"error"];
     NSString *stackTrace = call.arguments[@"stackTrace"];
     NSDictionary *extraInfo = call.arguments[@"extraInfo"];
     NSLog(@"type: %@ , error: %@ , stacktrace: %@",type,error,stackTrace);
     NSArray *stackTraceArray = [stackTrace componentsSeparatedByString:@""];
     [Bugly reportExceptionWithCategory:5 name:error reason:@" " callStack:stackTraceArray extraInfo:extraInfo terminateApp:NO];
  } else if ([@"setAppVersion" isEqualToString:call.method]){
     NSString *appVersion = call.arguments[@"appVersion"];
     NSLog(@"setAppVersion %@",appVersion);
     [Bugly updateAppVersion:appVersion];
  } else if ([@"setUserId" isEqualToString:call.method]){
     NSString *userId = call.arguments[@"userId"];
     NSLog(@"setUserId %@",userId);
     [Bugly setUserIdentifier:userId];
  } else if ([@"putUserData" isEqualToString:call.method]){
     NSString *userKey = call.arguments[@"userKey"];
     NSString *userValue = call.arguments[@"userValue"];
     NSLog(@"putUserData userKey %@ userValue %@ ",userKey,userValue);
     [Bugly setUserValue:userValue forKey:userKey];
  } else if([@"setUserSceneTag" isEqualToString:call.method]) {
     NSNumber *tagNumber = call.arguments[@"userSceneTag"];
     NSUInteger *tagInt = [tagNumber integerValue];
     [Bugly setTag:tagInt];
     NSLog(@"setUserSceneTag");
  } else if ([@"logd" isEqualToString:call.method]){
     NSString *tag = call.arguments[@"tag"];
     NSString *log = call.arguments[@"content"];
     [BuglyLog level:BuglyLogLevelDebug tag:tag log:log];
  } else if ([@"logi" isEqualToString:call.method]){
     NSString *tag = call.arguments[@"tag"];
     NSString *log = call.arguments[@"content"];
     [BuglyLog level:BuglyLogLevelInfo tag:tag log:log];
  } else if ([@"logv" isEqualToString:call.method]){
     NSString *tag = call.arguments[@"tag"];
     NSString *log = call.arguments[@"content"];
     [BuglyLog level:BuglyLogLevelVerbose tag:tag log:log];
  } else if ([@"logw" isEqualToString:call.method]){
     NSString *tag = call.arguments[@"tag"];
     NSString *log = call.arguments[@"content"];
     [BuglyLog level:BuglyLogLevelWarn tag:tag log:log];
  } else if ([@"loge" isEqualToString:call.method]){
     NSString *tag = call.arguments[@"tag"];
     NSString *log = call.arguments[@"content"];
     [BuglyLog level:BuglyLogLevelError tag:tag log:log];
  } else {
    result(FlutterMethodNotImplemented);
  }
}

@end
