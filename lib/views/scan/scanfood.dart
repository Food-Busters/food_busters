// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:camera/camera.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/scan/scanafter.dart";
import "package:food_busters/views/scan/scanbefore.dart";
import "package:food_busters/views/scan/scanportal.dart";

class ScanPage extends StatefulWidget {
  const ScanPage({Key? key, required this.cameras, required this.destination})
      : super(key: key);

  final List<CameraDescription> cameras;

  final scanDestination destination;

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
    final t = useTranslation(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(t.scan_your_food),
      ),
      body: cameraReady
          ? n.Stack([
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Center(child: CameraPreview(controller)),
              ),
              bgImage("clouds/surrounding_orange.webp"),
            ])
          : bgImage("loading.webp"),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 18.0),
        child: FloatingActionButton.extended(
          icon: const Icon(Icons.camera),
          label: const Text("SNAP"),
          backgroundColor: green,
          onPressed: cameraReady ? handleSnap : null,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<void> handleSnap() async {
    final appState = MyApp.of(context).state;

    if (controller.value.isTakingPicture) return;

    final XFile image = await controller.takePicture();
    if (widget.destination == scanDestination.before) {
      appState.imageBefore = image;
    } else {
      appState.imageAfter = image;
    }
    appState.save();

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => widget.destination == scanDestination.before
            ? const ScanBeforePage()
            : const ScanAfterPage(),
      ),
    );
  }
}
