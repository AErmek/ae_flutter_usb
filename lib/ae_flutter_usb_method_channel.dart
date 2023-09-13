// import 'package:flutter/foundation.dart';
// import 'package:flutter/services.dart';

// import 'ae_flutter_usb_platform_interface.dart';

// /// An implementation of [AeFlutterUsbPlatform] that uses method channels.
// class MethodChannelAeFlutterUsb extends AeFlutterUsbPlatform {
//   /// The method channel used to interact with the native platform.
//   @visibleForTesting
//   final methodChannel = const MethodChannel('ae_flutter_usb');

//   @override
//   Future<String?> getPlatformVersion() async {
//     final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
//     return version;
//   }
// }
