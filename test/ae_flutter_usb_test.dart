// import 'package:flutter_test/flutter_test.dart';
// import 'package:ae_flutter_usb/ae_flutter_usb.dart';
// import 'package:ae_flutter_usb/ae_flutter_usb_platform_interface.dart';
// import 'package:ae_flutter_usb/ae_flutter_usb_method_channel.dart';
// import 'package:plugin_platform_interface/plugin_platform_interface.dart';

// class MockAeFlutterUsbPlatform
//     with MockPlatformInterfaceMixin
//     implements AeFlutterUsbPlatform {

//   @override
//   Future<String?> getPlatformVersion() => Future.value('42');
// }

// void main() {
//   final AeFlutterUsbPlatform initialPlatform = AeFlutterUsbPlatform.instance;

//   test('$MethodChannelAeFlutterUsb is the default instance', () {
//     expect(initialPlatform, isInstanceOf<MethodChannelAeFlutterUsb>());
//   });

//   test('getPlatformVersion', () async {
//     AeFlutterUsb aeFlutterUsbPlugin = AeFlutterUsb();
//     MockAeFlutterUsbPlatform fakePlatform = MockAeFlutterUsbPlatform();
//     AeFlutterUsbPlatform.instance = fakePlatform;

//     expect(await aeFlutterUsbPlugin.getPlatformVersion(), '42');
//   });
// }
