import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';

/// Description:bugly futter plugin .
/// @author rockypzhang
/// @since 2019/5/28
class Bugly {
  static const MethodChannel _channel = const MethodChannel('bugly');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 初始化接口.
  /// @param appId appId
  /// @param isDebug 是否打开debug开关
  static Future<void> initAndroidCrashReport({
    String? appId,
    bool? isDebug,
  }) async {
    Map<String, Object?> map = {
      "appId": appId,
      "isDebug": isDebug,
    };
    _channel.invokeMethod("initCrashReport", map);
  }

  /// 自定义上报域名.
  /// @param url 自定义域名
  static Future<void> setAndroidServerUrl({
    String? url,
  }) async {
    if (Platform.isAndroid) {
      Map<String, Object?> map = {
        "url": url,
      };
      _channel.invokeMethod("setServerUrl", map);
    }
  }

  /// 设置App渠道.
  /// @param appChannel App渠道
  static Future<void> setAndroidAppChannel({
    String? appChannel,
  }) async {
    if (Platform.isAndroid) {
      Map<String, Object?> map = {
        "appChannel": appChannel,
      };
      _channel.invokeMethod("setAppChannel", map);
    }
  }

  /// 设置App包名
  /// @param appPackage App包名
  static Future<void> setAndroidAppPackage({
    String? appPackage,
  }) async {
    if (Platform.isAndroid) {
      Map<String, Object?> map = {
        "appPackage": appPackage,
      };
      _channel.invokeMethod("setAppPackage", map);
    }
  }

  /// 设置App 设备 id
  /// @param appPackage App包名
  static Future<void> setAndroidDeviceId({
    String? deviceId,
  }) async {
    if (Platform.isAndroid) {
      Map<String, Object?> map = {
        "deviceId": deviceId,
      };
      _channel.invokeMethod("setDeviceId", map);
    }
  }

  /// 初始化接口.
  /// @param appId appId
  static Future<void> initIosCrashReport({
    String? appId,
    bool? debugMode,
    String? serverUrl,
  }) async {
    Map<String, Object?> map = {
      "appId": appId,
      "debugMode": debugMode,
      "serverUrl": serverUrl
    };
    _channel.invokeMethod("initCrashReport", map);
  }

  /// 上报自定义异常.
  /// @param type 错误类型
  /// @param error 错误信息
  /// @param stackTrace 出错堆栈
  /// @param extraInfo 额外信息
  static Future<void> postException({
    String? type,
    String? error,
    String? stackTrace,
    Map<String, String>? extraInfo,
  }) async {
    Map<String, Object?> map = {
      "type": type,
      "error": error,
      "stackTrace": stackTrace,
      "extraInfo": extraInfo,
    };
    _channel.invokeMethod("postException", map);
  }

  /// 设置App版本
  /// @param appVersion App版本
  static Future<void> setAppVersion({
    String? appVersion,
  }) async {
    Map<String, Object?> map = {
      "appVersion": appVersion,
    };
    _channel.invokeMethod("setAppVersion", map);
  }

  /// 设置用户场景 ,可以在初始化前执行.
  /// @param userSceneTag 唯一标识一种场景，必须大于0
  static Future<void> setUserSceneTag({
    int? userSceneTag,
  }) async {
    Map<String, Object?> map = {
      "userSceneTag": userSceneTag,
    };
    _channel.invokeMethod("setUserSceneTag", map);
  }

  /// 设置用户id
  /// @param userSceneTag 唯一标识一种场景，必须大于0
  static Future<void> setUserId({
    String? userId,
  }) async {
    Map<String, Object?> map = {
      "userId": userId,
    };
    _channel.invokeMethod("setUserId", map);
  }

  /// 添加用户数据Key，Value.
  /// @param userKey 用户数据key
  /// @param userValue 用户数据value
  static Future<void> putUserData({
    String? userKey,
    String? userValue,
  }) async {
    Map<String, Object?> map = {
      "userKey": userKey,
      "userValue": userValue,
    };
    _channel.invokeMethod("putUserData", map);
  }
}
