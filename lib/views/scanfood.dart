import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:food_busters/views/scanresult.dart";

// ! Temporary, as in production we don't random user's result
import "dart:math";

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(widget.cameras[0], ResolutionPreset.veryHigh);
    controller.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan your Food"),
      ),
      body: controller.value.isInitialized
          ? Padding(
              padding: const EdgeInsets.all(24.0),
              child: CameraPreview(controller),
            )
          : Image.asset(
              "assets/images/loading.png",
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: () {
          if (controller.value.isInitialized) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ScanResultPage(percent: Random().nextInt(100) + 1),
              ),
            );
          }
        },
      ),
    );
  }
}
