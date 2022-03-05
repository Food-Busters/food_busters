// Flutter imports:
import "package:flutter/foundation.dart" show kIsWeb;
import "package:flutter/material.dart";

// Package imports:
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:niku/namespace.dart" as n;
import "package:package_info_plus/package_info_plus.dart";

// Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/profile_picture.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/mission/mission.dart";
import "package:food_busters/views/points/points.dart";
import "package:food_busters/views/record/leaderboard.dart";
import "package:food_busters/views/record/record.dart";
import "package:food_busters/views/scan/scanportal.dart";
import "package:food_busters/views/settings.dart";

const webAppWarn =
    "This app is not optimized for web, there may be some unexpected error, "
    "this is temporary for who that doesn't use Android. "
    "Will be removed in the future. "
    "Our UI is designed for Portrait mode, please rotate or "
    "change your window size.";

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    // Niku Reduced 25% Of Codes (Mostly Thicc Indent lol)
    // Lines of Code Reduced by ~10
    return Scaffold(
      backgroundColor: const Color(0xFFBCDFCB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: n.Text(text.home)
          ..color = Colors.black
          ..freezed,
        actions: [
          n.IconButton(Icons.settings)
            ..onPressed = () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          n.IconButton(Icons.info)
            ..onPressed = () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String version = packageInfo.version;
              showAboutDialog(
                context: context,
                applicationName: "Food Busters",
                applicationVersion: version,
                applicationIcon: Image.asset(
                  "assets/images/somwua_icon.png",
                  height: 80,
                ),
                children: [
                  n.Text("BRANCH: $appBranch")
                    ..center
                    ..freezed,
                  const SizedBox(height: 24),
                  const FlutterLogo(
                    style: FlutterLogoStyle.horizontal,
                    size: 30,
                  ),
                ],
              );
            },
        ],
      ),
      body: n.Stack([
        // * Background
        bgImage("clouds/top_green.png"),
        bgImage("clouds/bottom_tan.png"),
        // * Actual Contents
        n.Column([
          n.Column([
            n.Column([
              n.Row([
                n.Text("\"${text.greetings}, ")
                  ..fontSize = 18
                  ..freezed,
                n.Text("${widget.username}\"")
                  ..fontSize = 26
                  ..freezed,
              ])
                ..mainStart
                ..crossBaseline
                ..alphabetic,
              n.Text(text.have_a_nice_meal)
                ..fontSize = 16
                ..freezed,
              kIsWeb
                  ? Text(
                      webAppWarn,
                      style: TextStyle(color: Colors.red[400]),
                    )
                  : Container(),
            ])
              ..crossStart
              ..p = 16,
            profilePic(discordPfp, 100),
          ]),
          navButtons(text)..p = 8,
        ])
          ..mainEvenly
          ..useParent(vCenter),
      ]),
    );
  }

  n.Column navButtons(AppLocalizations text) {
    return n.Column([
      bigBtn(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ScanPortalPage(),
            ),
          );
        },
        content: text.scan + "!",
        padding: 20,
        assetName: "scan.png",
      ),
      n.Row([
        Expanded(
          flex: 1,
          child: smallBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyPoints(),
                ),
              );
            },
            content: text.my_points,
            assetName: "points.png",
          ),
        ),
        Expanded(
          flex: 1,
          child: smallBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyRecordPage(),
                ),
              );
            },
            content: text.my_record,
            assetName: "record.png",
          ),
        ),
      ])
        ..mainCenter
        ..freezed,
      n.Row([
        Expanded(
          flex: 1,
          child: smallBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyMissionPage(),
                ),
              );
            },
            content: text.mission,
            assetName: "mission.png",
          ),
        ),
        Expanded(
          flex: 1,
          child: smallBtn(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LeaderboardPage(),
                ),
              );
            },
            content: text.leaderboard,
            assetName: "leaderboard.png",
          ),
        )
      ])
        ..mainCenter
        ..freezed,
    ]);
  }

  Widget bigBtn({
    required void Function() onPressed,
    required String content,
    required double padding,
    required String assetName,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: n.Row([
          Image.asset("assets/images/icons/$assetName", height: 50),
          n.Text(content)
            ..fontSize = 26
            ..freezed,
        ])
          ..mainCenter,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          primary: lightOrange,
          minimumSize: const Size(275, 0),
        ),
      ),
    );
  }

  Widget smallBtn({
    required void Function() onPressed,
    required String content,
    required String assetName,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: n.Column([
          Image.asset("assets/images/icons/$assetName", height: 50),
          n.Text(content)
            ..fontSize = 14
            ..freezed,
        ]),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          primary: lightGreen,
        ),
      ),
    );
  }
}
