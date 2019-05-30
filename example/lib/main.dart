import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:bugly_crash/bugly.dart';
import 'package:bugly_crash/buglyLog.dart';

//void main() => runApp(MyApp());
Map<String,String> extraInfo = {"key1":"value1","key2":"value2","key3":"value1"};

Future<Null> main() async {
  //测试APP未捕获到的异常上报
  FlutterError.onError = (FlutterErrorDetails details) async {
    print("zone current print error");
    Zone.current.handleUncaughtError(details.exception, details.stack);
  };

  runZoned<Future<Null>>(() async {
    runApp(MyApp());
  }, onError: (error, stackTrace) async {
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
    Bugly.setAppVersion(appVersion:"1.9.2");
    Bugly.setAppChannel(appChannel: "flutter_test");
    Bugly.setAppPackage(appPackage: "com.bugly.flutter.test");
    Bugly.setUserSceneTag(userSceneTag: 30);
    Bugly.putUserData(userKey:"userkey1",userValue:"uservalue1");
    Bugly.putUserData(userKey:"userkey2",userValue:"uservalue2");
    BuglyLog.d(tag:"d",content:"value");
    BuglyLog.i(tag:"i",content:"value");
    BuglyLog.v(tag:"v",content:"value");
    BuglyLog.w(tag:"w",content:"value");
    BuglyLog.e(tag:"e",content:"value");
    Bugly.setIsDevelopmentDevice(isDevelopmentDevice: true);
    Bugly.initCrashReport(appId:"d562178d23",isDebug: true);
    initPlatformState();
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

    //测试APP自己捕获到的异常上报
    try {
      String s ;
      s.trim();
    } catch (e){
      String type = "flutter caught error";
      await Bugly.postException(type:type,error:"null exception",stackTrace:e.toString(),extraInfo:extraInfo);
    }

    //测试APP未捕获到的异常上报
    throw 'bugly flutter uncaught error test';

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
