import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class ScanBeforePage extends StatefulWidget {
  const ScanBeforePage({Key? key, required this.image}) : super(key: key);

  final XFile image;

  @override
  _ScanBeforePageState createState() => _ScanBeforePageState();
}

class _ScanBeforePageState extends State<ScanBeforePage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.scan_result),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
