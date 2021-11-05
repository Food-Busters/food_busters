import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/mission/mission.dart";
import "package:food_busters/views/points/points.dart";
import "package:food_busters/views/record/leaderboard.dart";
import "package:food_busters/views/record/record.dart";
import "package:food_busters/views/scan/scanportal.dart";
import "package:food_busters/views/settings.dart";
import "package:package_info_plus/package_info_plus.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

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

    return Scaffold(
      backgroundColor: const Color(0xFFBCDFCB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(text.home, style: const TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () async {
              PackageInfo packageInfo = await PackageInfo.fromPlatform();
              String appName = packageInfo.appName;
              String version = packageInfo.version;
              showAboutDialog(
                context: context,
                applicationName: appName,
                applicationVersion: version,
                applicationIcon: Image.asset(
                  "assets/images/logo_white.jpg",
                  height: 80,
                ),
                children: [
                  const Text("BRANCH: $appBranch", textAlign: TextAlign.center),
                  const SizedBox(height: 24),
                  const FlutterLogo(
                    style: FlutterLogoStyle.horizontal,
                    size: 30,
                  ),
                ],
              );
            },
          )
        ],
      ),
      body: Stack(
        children: [
          // * Background
          bgImage("clouds/top_green.png"),
          bgImage("clouds/bottom_tan.png"),
          // * Actual Contents
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(
                                "\"${text.greetings}, ",
                                style: const TextStyle(fontSize: 18),
                              ),
                              Text(
                                "${widget.username}\"",
                                style: const TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                          Text(
                            text.have_a_nice_meal,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(discordPfp),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
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
                        icon: Icons.camera_alt,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              icon: Icons.monetization_on_outlined,
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
                              icon: Icons.timeline,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                              icon: Icons.notification_important,
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: smallBtn(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const LeaderboardPage(),
                                  ),
                                );
                              },
                              content: text.leaderboard,
                              icon: Icons.badge,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bigBtn({
    required void Function() onPressed,
    required String content,
    required double padding,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon),
            Text(content, style: const TextStyle(fontSize: 26)),
          ],
        ),
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
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Column(
          children: [
            Icon(icon),
            Text(content, style: const TextStyle(fontSize: 14)),
          ],
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15),
          primary: lightGreen,
        ),
      ),
    );
  }
}
