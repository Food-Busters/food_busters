import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/views/scanresult.dart";

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  late CameraController controller;

  bool get cameraReady => controller.value.isInitialized;

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Scan your Food"),
      ),
      body: cameraReady
          ? Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Center(child: CameraPreview(controller)),
                ),
                bgImage("assets/images/clouds/surrounding.png"),
              ],
            )
          : bgImage("assets/images/loading.png"),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera),
        onPressed: cameraReady
            ? () async {
                if (controller.value.isTakingPicture) return;
                final XFile image = await controller.takePicture();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanResultPage(image: image),
                  ),
                );
              }
            : null,
      ),
    );
  }
}
