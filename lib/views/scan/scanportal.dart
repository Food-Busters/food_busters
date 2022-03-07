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
import "package:food_busters/views/scan/scanfood.dart";

enum scanDestination {
  before,
  after,
}

class ScanPortalPage extends StatefulWidget {
  const ScanPortalPage({Key? key}) : super(key: key);

  @override
  _ScanPortalPageState createState() => _ScanPortalPageState();
}

class _ScanPortalPageState extends State<ScanPortalPage> {
  Future<void> goToScanPage(
    BuildContext context,
    scanDestination destination,
  ) async {
    final cameras = await availableCameras();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScanPage(
          cameras: cameras,
          destination: destination,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(t.scan),
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.webp"),
        bgImage("clouds/top_orange.webp"),
        n.Column([
          n.Row([
            ElevatedButton(
              onPressed: appState.imageBeforeAvailable
                  ? null
                  : () {
                      goToScanPage(context, scanDestination.before);
                    },
              child: Text(
                t.before,
                style: const TextStyle(fontSize: 24),
              ),
              style: ElevatedButton.styleFrom(
                primary: lightOrange,
                padding: const EdgeInsets.all(8.0),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: appState.imageBeforeAvailable
                  ? () {
                      setState(() {
                        appState.deleteImageBefore();
                      });
                    }
                  : null,
              child: const Icon(Icons.delete),
            ),
          ])
            ..mainCenter,
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: appState.imageBeforeAvailable
                ? () {
                    goToScanPage(context, scanDestination.after);
                  }
                : null,
            child: Text(
              t.after,
              style: const TextStyle(fontSize: 24),
            ),
            style: ElevatedButton.styleFrom(
              primary: lightGreen,
              padding: const EdgeInsets.all(8.0),
              minimumSize: const Size(220, 0),
            ),
          ),
        ])
          ..mainCenter
          ..useParent(vCenter)
      ]),
    );
  }
}
