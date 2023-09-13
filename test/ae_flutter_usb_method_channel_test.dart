// import 'package:flutter/services.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:ae_flutter_usb/ae_flutter_usb_method_channel.dart';

// void main() {
//   MethodChannelAeFlutterUsb platform = MethodChannelAeFlutterUsb();
//   const MethodChannel channel = MethodChannel('ae_flutter_usb');

//   TestWidgetsFlutterBinding.ensureInitialized();

//   setUp(() {
//     channel.setMockMethodCallHandler((MethodCall methodCall) async {
//       return '42';
//     });
//   });

//   tearDown(() {
//     channel.setMockMethodCallHandler(null);
//   });

//   test('getPlatformVersion', () async {
//     expect(await platform.getPlatformVersion(), '42');
//   });
// }
