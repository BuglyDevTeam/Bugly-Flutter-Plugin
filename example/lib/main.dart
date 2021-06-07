import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bugly_crash/bugly.dart';
import 'package:bugly_crash/buglyLog.dart';
import 'dart:io';

//void main() => runApp(MyApp());
Map<String,String> extraInfo = {"key1":"value1","key2":"value2","key3":"value1"};

Future<Null> main() async {
  //一、这里配置上报APP未捕获到的异常，业务可以自由决定上报的信息
  FlutterError.onError = (FlutterErrorDetails details) async {
    print("zone current print error");
    Zone.current.handleUncaughtError(details.exception, details.stack!);
  };

  runZonedGuarded<Future<Null>>(() async {
    runApp(MyApp());
  }, (error, stackTrace) async {
    String type = "flutter uncaught error";
    await Bugly.postException(type:type,error: error.toString(),stackTrace: stackTrace.toString(),extraInfo:extraInfo);
  });
}


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
    if(Platform.isAndroid){
      initBuglyAndroid();
    }else if(Platform.isIOS){
      initBuglyIos();
    }
  }

  void initBuglyAndroid(){
    //Bugly.setAndroidServerUrl(url: "https://xxxx");
    Bugly.initAndroidCrashReport(appId:"c50a711298",isDebug: true);
    Bugly.setUserId(userId:"androiduser");
    //如果遇到AndroidId采集隐私问题，可以参考https://github.com/BuglyDevTeam/Bugly-Android-Demo
    Bugly.setAndroidDeviceId(deviceId: "test");
    Bugly.setUserSceneTag(userSceneTag: 111437);
    Bugly.setAppVersion(appVersion:"1.9.3");
    Bugly.setAndroidAppChannel(appChannel: "test");
    //bugly自定义日志,可在"跟踪日志"页面查看
    BuglyLog.d(tag:"bugly",content:"debugvalue");
    BuglyLog.i(tag:"bugly",content:"infovalue");
    BuglyLog.v(tag:"bugly",content:"verbosevalue");
    BuglyLog.w(tag:"bugly",content:"warnvalue");
    BuglyLog.e(tag:"bugly",content:"errorvalue");
    //自定义map参数 可在"跟踪数据"页面查看
    Bugly.putUserData(userKey:"userkey1",userValue:"uservalue1");
    Bugly.putUserData(userKey:"userkey2",userValue:"uservalue2");
  }

  void initBuglyIos(){
    Bugly.initIosCrashReport(appId:"87654c7bfa",debugMode: true);
    Bugly.setUserSceneTag(userSceneTag: 116852);
    Bugly.setAppVersion(appVersion:"1.9.2");
    Bugly.putUserData(userKey:"userkey1",userValue:"uservalue1");
    Bugly.setUserId(userId:"iosuser");
    BuglyLog.d(tag:"bugly",content:"debugvalue");
    BuglyLog.i(tag:"bugly",content:"infovalue");
    BuglyLog.w(tag:"bugly",content:"warnvalue");
    BuglyLog.v(tag:"bugly",content:"verbosevalue");
    BuglyLog.e(tag:"bugly",content:"errorvalue");
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await Bugly.platformVersion;
    } on PlatformException{
      platformVersion = 'Failed to get platform version.';
    }


    //(1)测试APP自己捕获到的异常上报
    try {
      var list = [1,2];
      list[3] = 1;
    } catch (e){
      String type = "flutter caught error";
      await Bugly.postException(type:type,error:"null exception",stackTrace:e.toString(),extraInfo:extraInfo);
    }

    //(2)测试APP未捕获到的异常上报
    //throw 'bugly flutter uncaught error test';
    var list = [1,2];
    list[3] = 1;

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  _onClick(){
    throw 'bugly flutter uncaught error test';
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: GestureDetector(
            onTap: _onClick,
            child: Text('Running on: $_platformVersion\n'),
          )
        ),
      ),
    );
  }
}
