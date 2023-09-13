import 'dart:typed_data';

import 'package:ae_flutter_usb/ae_flutter_usb.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ae_flutter_usb_method_channel.dart';

abstract class AeFlutterUsbPlatform extends PlatformInterface {
  /// Constructs a AeFlutterUsbPlatform.
  AeFlutterUsbPlatform() : super(token: _token);

  static final Object _token = Object();

  static late AeFlutterUsbPlatform _instance;

  /// The default instance of [AeFlutterUsbPlatform] to use.
  ///
  /// Defaults to [MethodChannelAeFlutterUsb].
  static AeFlutterUsbPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AeFlutterUsbPlatform] when
  /// they register themselves.
  static set instance(AeFlutterUsbPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> init();

  Future<void> exit();

  Future<List<UsbDevice>> getDeviceList();

  Future<List<UsbDeviceDescription>> getDevicesWithDescription(
      {bool requestPermission = true});

  Future<UsbDeviceDescription> getDeviceDescription(UsbDevice usbDevice,
      {bool requestPermission = true});

  Future<bool> hasPermission(UsbDevice usbDevice);

  Future<bool> requestPermission(UsbDevice usbDevice);

  Future<bool> openDevice(UsbDevice usbDevice);

  Future<void> closeDevice();

  Future<UsbConfiguration> getConfiguration(int index);

  Future<bool> setConfiguration(UsbConfiguration config);

  Future<bool> claimInterface(UsbInterface intf);

  Future<bool> detachKernelDriver(UsbInterface intf);

  Future<bool> releaseInterface(UsbInterface intf);

  Future<Uint8List> bulkTransferIn(
      UsbEndpoint endpoint, int maxLength, int timeout);

  Future<int> bulkTransferOut(
      UsbEndpoint endpoint, Uint8List data, int timeout);

  Future<void> setAutoDetachKernelDriver(bool enable);
}
