import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';

getDeviceDetails() async {
  String deviceName;
  String deviceVersion;
  String identifier;
  String os;
  final DeviceInfoPlugin deviceInfoPlugin =  DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      var build = await deviceInfoPlugin.androidInfo;
      os = 'Android';
      deviceName = build.model;
      deviceVersion = build.version.toString();
      identifier = build.androidId; //unique ID on Android
    } else if (Platform.isIOS) {
      var data = await deviceInfoPlugin.iosInfo;
      os = 'IOS';
      deviceName = data.name;
      deviceVersion = data.systemVersion;
      identifier = data.identifierForVendor; //unique ID on iOS
    }
  } on PlatformException {
    print('Failed to get platform version');
  }

  //if (!mounted) return;

  // print('${deviceName}, ${deviceVersion}, ${identifier} , ${os}');
  // return [deviceName, deviceVersion, identifier, Platform.isIOS];
  return {'os': os, 'identifier': identifier};
  // return 'dsfsdfsdfs';
  // IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  // print('Running on ${iosInfo.utsname.machine}');
}
