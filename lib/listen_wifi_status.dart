import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ListenWifiStatus extends StatefulWidget {
  const ListenWifiStatus({super.key});

  @override
  State<ListenWifiStatus> createState() => _ListenWifiStatusState();
}

class _ListenWifiStatusState extends State<ListenWifiStatus> {
  String? wifiStatus;
  EventChannel channel =
      const EventChannel('com.example.native_channel_example/wifi');

  @override
  void initState() {
    super.initState();
    _listenWifiStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(wifiStatus ?? "Unknown"),
          ],
        ),
      ),
    );
  }

  _listenWifiStatus() async {
    String wifiStatusFromNativeSide;
    try {
      channel.receiveBroadcastStream().listen((event) {
        setState(() {
          wifiStatus = event;
        });
      });
    } on PlatformException catch (e) {
      wifiStatusFromNativeSide = "Failed to get wifi status: '${e.message}'.";
      setState(() {
        wifiStatus = wifiStatusFromNativeSide;
      });
    }
  }
}
