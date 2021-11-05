import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";

class HealthStatusPage extends StatefulWidget {
  const HealthStatusPage({Key? key}) : super(key: key);

  @override
  _HealthStatusPageState createState() => _HealthStatusPageState();
}

class _HealthStatusPageState extends State<HealthStatusPage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.my_record),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
        ],
      ),
    );
  }
}
