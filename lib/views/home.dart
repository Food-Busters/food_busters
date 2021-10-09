import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/views/scanfood.dart";
import "package:food_busters/views/settings.dart";
import "package:package_info_plus/package_info_plus.dart";

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFBCDFCB),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Home", style: TextStyle(color: Colors.black)),
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
          bgImage("assets/images/clouds/top_green.png"),
          bgImage("assets/images/clouds/bottom_tan.png"),
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
                              const Text(
                                "\"GREETINGS, ",
                                style: TextStyle(fontSize: 18),
                              ),
                              Text(
                                "${widget.username}\"",
                                style: const TextStyle(fontSize: 26),
                              ),
                            ],
                          ),
                          const Text(
                            "Have a nice Meal!",
                            style: TextStyle(fontSize: 16),
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
                          image: NetworkImage(
                            "https://external-preview.redd.it/4PE-nlL_PdMD5PrFNLnjurHQ1QKPnCvg368LTDnfM-M.png?auto=webp&s=ff4c3fbc1cce1a1856cff36b5d2a40a6d02cc1c3",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    bigBtn(
                      onPressed: () async {
                        final cameras = await availableCameras();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScanPage(cameras: cameras),
                          ),
                        );
                      },
                      content: "SCAN!",
                      padding: 20,
                    ),
                    bigBtn(onPressed: () {}, content: "MY POINTS", padding: 15),
                    bigBtn(onPressed: () {}, content: "MY RECORD", padding: 15),
                  ],
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
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(content, style: const TextStyle(fontSize: 26)),
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(padding),
          primary: const Color(0xFFFFC478),
        ),
      ),
    );
  }
}
