import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class PollutionInfo extends StatefulWidget {
  const PollutionInfo({Key? key, required this.percent}) : super(key: key);

  final int percent;

  @override
  _PollutionInfoState createState() => _PollutionInfoState();
}

class _PollutionInfoState extends State<PollutionInfo> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.learn_more),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/top_orange.png"),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                text.pollution_produced.replaceAll(
                  "{pollution}",
                  "${(100 - widget.percent) * 10}",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
