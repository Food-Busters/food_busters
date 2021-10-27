import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
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
    Navigator.of(context).pop();
    Navigator.push(
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
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(text.scan),
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    goToScanPage(context, scanDestination.before);
                  },
                  child: Text(
                    text.before,
                    style: const TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: lightOrange,
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: () {
                    goToScanPage(context, scanDestination.after);
                  },
                  child: Text(
                    text.after,
                    style: const TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: lightGreen,
                    padding: const EdgeInsets.all(8.0),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
