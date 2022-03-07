// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/buttons.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/styles/styles.dart";

class ScanBeforePage extends StatefulWidget {
  const ScanBeforePage({Key? key}) : super(key: key);

  @override
  _ScanBeforePageState createState() => _ScanBeforePageState();
}

class _ScanBeforePageState extends State<ScanBeforePage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: brown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_hybrid.webp"),
        n.Column([
          n.Text(t.scan_before_title)
            ..fontSize = 32
            ..color = Colors.white
            ..w500
            ..freezed,
          n.Text(t.scan_before_content)
            ..fontSize = 24
            ..color = Colors.white
            ..center
            ..useParent((v) => v..p = 24)
            ..freezed,
          backHomeBtn(context),
        ])
          ..mainCenter
          ..freezed,
      ]),
    );
  }
}
