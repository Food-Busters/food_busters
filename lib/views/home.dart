// 🐦 Flutter imports:
import "package:flutter/foundation.dart" show kIsWeb;
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;
import "package:package_info_plus/package_info_plus.dart";

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/profile_picture.dart";
import "package:food_busters/constants/app_props.dart";
import "package:food_busters/hooks.dart";
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
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      backgroundColor: const Color(0xFFBCDFCB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: n.Text(t.home)..color = Colors.black,
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
                  "assets/images/somwua_icon.webp",
                  height: 80,
                ),
                children: [
                  n.Text("BRANCH: ${AppProps.branch}")
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
        bgImage("clouds/top_green.webp"),
        bgImage("clouds/bottom_tan.webp"),
        // * Actual Contents
        n.Column([
          n.Column([
            n.Column([
              n.Row([
                n.Text("\"${t.greetings}, ")
                  ..fontSize = 18
                  ..freezed,
                n.Text("${appState.username}\"")
                  ..fontSize = 26
                  ..freezed,
              ])
                ..mainStart
                ..crossBaseline
                ..alphabetic,
              n.Text(t.have_a_nice_meal)
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
            profilePic("assets/images/somwua_icon.webp", 100),
          ]),
          navButtons()..p = 8,
        ])
          ..mainEvenly
          ..useParent(vCenter),
      ]),
    );
  }

  n.Column navButtons() {
    final t = useTranslation(context);
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
        content: t.scan + "!",
        padding: 20,
        assetName: "scan.webp",
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
            content: t.my_points,
            assetName: "points.webp",
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
            content: t.my_record,
            assetName: "record.webp",
          ),
        ),
      ])
        ..mainCenter,
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
            content: t.mission,
            assetName: "mission.webp",
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
            content: t.leaderboard,
            assetName: "leaderboard.webp",
          ),
        )
      ])
        ..mainCenter,
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
          n.Text(content)..fontSize = 26,
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
          n.Text(content)..fontSize = 14,
        ]),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          primary: lightGreen,
        ),
      ),
    );
  }
}
