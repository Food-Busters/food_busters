// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/record/leaderboard.dart";

class OtherBustersPage extends StatefulWidget {
  const OtherBustersPage({Key? key}) : super(key: key);

  @override
  _OtherBustersPageState createState() => _OtherBustersPageState();
}

class _OtherBustersPageState extends State<OtherBustersPage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.other_busters),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.webp"),
        bgImage("clouds/top_orange.webp"),
        Center(
          child: n.Column([
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: thanksBuster(text),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardPage(),
                  ),
                );
              },
              child: Text(text.leaderboard),
              style: lightGreenBtn,
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: kurzInfo(text, -7, -52, 19),
            ),
          ])
            ..mainCenter
            ..useParent(vCenter),
        ),
      ]),
    );
  }

  Widget thanksBuster(AppLocalizations text) {
    return n.Column([
      Text(text.thanks_buster_1),
      Text(text.thanks_buster_2),
    ])
      ..crossStart;
  }

  Widget kurzInfo(
    AppLocalizations text,
    int carbonDiff,
    int ch4Diff,
    int calDiff,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: n.Column([
        Text(text.you_produced + "..."),
        superRichText(carbonDiff, text.more_carbon, text.less_carbon),
        superRichText(ch4Diff, text.more_methane, text.less_methane),
        superRichText(calDiff, text.more_calories, text.less_calories),
      ])
        ..crossStart
        ..p = 24,
    );
  }

  Widget superRichText(int diff, String contentMore, String contentLess) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: 18.0,
          color: Colors.black,
          fontFamily: "Kanit",
        ),
        children: [
          const TextSpan(text: "- "),
          TextSpan(
            text: "${diff.abs()}% ",
            style: TextStyle(
              color: diff > 0 ? lightOrange : green,
            ),
          ),
          TextSpan(text: diff > 0 ? contentMore : contentLess),
        ],
      ),
    );
  }
}
