import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
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
    final text = AppLocalizations.of(context)!;
    final appState = MyApp.of(context).state;

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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: appState.imageBeforeAvailable
                          ? null
                          : () {
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
                  ],
                ),
                const SizedBox(height: 48),
                ElevatedButton(
                  onPressed: appState.imageBeforeAvailable
                      ? () {
                          goToScanPage(context, scanDestination.after);
                        }
                      : null,
                  child: Text(
                    text.after,
                    style: const TextStyle(fontSize: 24),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: lightGreen,
                    padding: const EdgeInsets.all(8.0),
                    minimumSize: const Size(220, 0),
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
