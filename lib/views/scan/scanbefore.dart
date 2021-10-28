import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/components/buttons.dart";
import "package:food_busters/styles/styles.dart";

class ScanBeforePage extends StatefulWidget {
  const ScanBeforePage({Key? key}) : super(key: key);

  @override
  _ScanBeforePageState createState() => _ScanBeforePageState();
}

class _ScanBeforePageState extends State<ScanBeforePage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/top_hybrid.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text.scan_before_title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 32,
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(
                  text.scan_before_content,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              backHomeBtn(context, text),
            ],
          ),
        ],
      ),
    );
  }
}
