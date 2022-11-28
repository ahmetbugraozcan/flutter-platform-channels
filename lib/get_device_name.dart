import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GetDeviceName extends StatefulWidget {
  const GetDeviceName({super.key});

  @override
  State<GetDeviceName> createState() => _GetDeviceNameState();
}

class _GetDeviceNameState extends State<GetDeviceName> {
  String? deviceName;
  MethodChannel channel =
      const MethodChannel("com.example.native_channel_example/device");

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(deviceName ?? ""),
            ElevatedButton(
              onPressed: () async => _getDeviceName(),
              child: const Text("Get Device Name"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getDeviceName() async {
    String deviceNameFromNativeSide;
    try {
      final String result =
          await channel.invokeMethod('getDeviceNameFromNative');
      deviceNameFromNativeSide = 'Device name is $result .';
    } on PlatformException catch (e) {
      deviceNameFromNativeSide = "Failed to get device name: '${e.message}'.";
    }

    setState(() {
      deviceName = deviceNameFromNativeSide;
    });
  }
}
