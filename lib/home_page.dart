import 'package:flutter/material.dart';
import 'package:native_channel_example/pigeon_example.dart';

import 'get_device_name.dart';
import 'listen_wifi_status.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: "Get Device Name"),
                Tab(text: "Listen Wifi Status"),
                Tab(text: "Pigeon Example"),
              ],
            ),
            body: TabBarView(
              children: [
                GetDeviceName(),
                ListenWifiStatus(),
                PigeonExample(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
