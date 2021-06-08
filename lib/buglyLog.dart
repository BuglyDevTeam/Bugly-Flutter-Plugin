import 'dart:async';

import 'package:flutter/services.dart';

class BuglyLog {
  static const MethodChannel _channel = const MethodChannel('bugly');

  static Future<void> d({
    String? tag,
    String? content,
  }) async {
    Map<String, Object?> map = {
      "tag": tag,
      "content": content,
    };
    _channel.invokeMethod("logd", map);
  }

  static Future<void> i({
    String? tag,
    String? content,
  }) async {
    Map<String, Object?> map = {
      "tag": tag,
      "content": content,
    };
    _channel.invokeMethod("logi", map);
  }

  static Future<void> v({
    String? tag,
    String? content,
  }) async {
    Map<String, Object?> map = {
      "tag": tag,
      "content": content,
    };
    _channel.invokeMethod("logv", map);
  }

  static Future<void> w({
    String? tag,
    String? content,
  }) async {
    Map<String, Object?> map = {
      "tag": tag,
      "content": content,
    };
    _channel.invokeMethod("logw", map);
  }

  static Future<void> e({
    String? tag,
    String? content,
  }) async {
    Map<String, Object?> map = {
      "tag": tag,
      "content": content,
    };
    _channel.invokeMethod("loge", map);
  }
}
