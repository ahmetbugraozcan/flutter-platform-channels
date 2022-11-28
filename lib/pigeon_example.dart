import 'package:flutter/material.dart';
import 'package:native_channel_example/pigeon.dart';

class PigeonExample extends StatefulWidget {
  const PigeonExample({super.key});

  @override
  State<PigeonExample> createState() => _PigeonExampleState();
}

class _PigeonExampleState extends State<PigeonExample> {
  List<Cat?> cats = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cats.length,
                itemBuilder: (context, index) => Text(cats[index]?.name ?? ""),
              ),
            ),
            ElevatedButton(
              onPressed: getCats,
              child: const Text("Get Cats"),
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }

  Future<void> getCats() async {
    final List<Cat?> cats = await CatApi().getCats();

    setState(() {
      this.cats = cats;
    });
  }
}
