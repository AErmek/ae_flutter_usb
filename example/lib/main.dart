// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:ae_flutter_usb/ae_flutter_usb.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

void main() {
  runApp(const MyHome());
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: const MyApp(),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return _buildColumn();
  }

  void log(String info) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(info)));
  }

  Widget _buildColumn() {
    return Column(
      children: [
        _init_exit(),
        _getDeviceList(),
        _getDevicesWithDescription(),
        _getDeviceDescription(),
        if (Platform.isLinux) _setAutoDetachKernelDriver(),
        _has_request(),
        _open_close(),
        _get_set_configuration(),
        _claim_release_interface(),
        _bulk_transfer(),
      ],
    );
  }

  Widget _init_exit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('init'),
          onPressed: () async {
            var init = await AeFlutterUsb.init();
            log('init $init');
          },
        ),
        ElevatedButton(
          child: const Text('exit'),
          onPressed: () async {
            await AeFlutterUsb.exit();
            log('exit');
          },
        ),
      ],
    );
  }

  List<UsbDevice>? _deviceList;
  UsbDevice? _selectedDevice;
  UsbConfiguration? configuration;

  Widget _getDeviceList() {
    return ElevatedButton(
      child: const Text('getDeviceList'),
      onPressed: () async {
        _deviceList = await AeFlutterUsb.getDeviceList();
        _selectedDevice =
            _deviceList?.firstWhereOrNull((x) => x.identifier == "48");
        log('deviceList $_deviceList');
      },
    );
  }

  Widget _has_request() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('hasPermission'),
          onPressed: () async {
            var hasPermission =
                await AeFlutterUsb.hasPermission(_selectedDevice!);
            log('hasPermission $hasPermission');
          },
        ),
        ElevatedButton(
          child: const Text('requestPermission'),
          onPressed: () async {
            await AeFlutterUsb.requestPermission(_deviceList!.first);
            log('requestPermission');
          },
        ),
      ],
    );
  }

  Widget _open_close() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('openDevice'),
          onPressed: () async {
            var openDevice = await AeFlutterUsb.openDevice(_selectedDevice!);
            log('openDevice $openDevice');
          },
        ),
        ElevatedButton(
          child: const Text('closeDevice'),
          onPressed: () async {
            await AeFlutterUsb.closeDevice();
            log('closeDevice');
          },
        ),
      ],
    );
  }

  UsbConfiguration? _configuration;

  Widget _get_set_configuration() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('getConfiguration'),
          onPressed: () async {
            _configuration =
                await AeFlutterUsb.getConfiguration(_selectedDevice!.productId);
            log('getConfiguration $_configuration');
          },
        ),
        ElevatedButton(
          child: const Text('setConfiguration'),
          onPressed: () async {
            var setConfiguration =
                await AeFlutterUsb.setConfiguration(_configuration!);
            log('setConfiguration $setConfiguration');
          },
        ),
      ],
    );
  }

  Widget _claim_release_interface() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('claimInterface'),
          onPressed: () async {
            var claimInterface = await AeFlutterUsb.claimInterface(
                _configuration!.interfaces[0]);
            log('claimInterface $claimInterface');
          },
        ),
        ElevatedButton(
          child: const Text('releaseInterface'),
          onPressed: () async {
            var releaseInterface = await AeFlutterUsb.releaseInterface(
                _configuration!.interfaces[0]);
            log('releaseInterface $releaseInterface');
          },
        ),
      ],
    );
  }

  Widget _bulk_transfer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: const Text('bulkTransferIn'),
          onPressed: () async {
            var endpoint = _configuration!.interfaces[0].endpoints
                .firstWhere((e) => e.direction == UsbEndpoint.DIRECTION_IN);
            var bulkTransferIn =
                await AeFlutterUsb.bulkTransferIn(endpoint, 1024);
            log('bulkTransferIn ${hex.encode(bulkTransferIn)}');
          },
        ),
        ElevatedButton(
          child: const Text('bulkTransferOut'),
          onPressed: () async {
            var data = Uint8List.fromList(utf8.encode(''));
            var endpoint = _configuration!.interfaces[0].endpoints
                .firstWhere((e) => e.direction == UsbEndpoint.DIRECTION_OUT);
            var bulkTransferOut =
                await AeFlutterUsb.bulkTransferOut(endpoint, data);
            log('bulkTransferOut $bulkTransferOut');
          },
        ),
      ],
    );
  }

  Widget _getDevicesWithDescription() {
    return ElevatedButton(
      child: const Text('getDevicesWithDescription'),
      onPressed: () async {
        var descriptions = await AeFlutterUsb.getDevicesWithDescription();
        _deviceList = descriptions.map((e) => e.device).toList();
        log('descriptions $descriptions');
      },
    );
  }

  Widget _getDeviceDescription() {
    return ElevatedButton(
      child: const Text('getDeviceDescription'),
      onPressed: () async {
        var description =
            await AeFlutterUsb.getDeviceDescription(_selectedDevice!);
        log('description ${description.toMap()}');
      },
    );
  }

  bool _autoDetachEnabled = false;
  Widget _setAutoDetachKernelDriver() {
    return ElevatedButton(
      child: const Text('setAutoDetachKernelDriver'),
      onPressed: () async {
        await AeFlutterUsb.setAutoDetachKernelDriver(!_autoDetachEnabled);
        _autoDetachEnabled = !_autoDetachEnabled;
        log('setAutoDetachKernelDriver: $_autoDetachEnabled');
      },
    );
  }
}
