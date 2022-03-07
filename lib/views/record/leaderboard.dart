// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_toggle_tab/flutter_toggle_tab.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/green_leaves.dart";
import "package:food_busters/components/profile_picture.dart";
import "package:food_busters/data/dummy_busters.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/models/buster.dart";
import "package:food_busters/styles/styles.dart";

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  bool _panel = false;

  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.leaderboard),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        n.Column([
          const SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 28,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: n.Column([
                profilePic("assets/images/somwua_icon.webp", 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: bigNeonLeaves(4),
                ),
              ])
                ..crossCenter
                ..p = 24,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 350,
              decoration: BoxDecoration(
                color: lightGreen,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 4.0,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlutterToggleTab(
                        width: 80,
                        borderRadius: 30,
                        height: 50,
                        selectedIndex: _panel ? 1 : 0,
                        selectedTextStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        unSelectedTextStyle: const TextStyle(
                          color: Colors.black87,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                        labels: [t.top_busters, t.friends],
                        selectedLabelIndex: (index) {
                          setState(() {
                            _panel = index == 0 ? false : true;
                          });
                        },
                        selectedBackgroundColors: const [tan],
                      ),
                    ),
                    SizedBox(
                      height: 260,
                      child: topBusters(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ])
          ..mainCenter
          ..useParent(vCenter),
      ]),
    );
  }

  Widget topBusters() {
    final t = useTranslation(context);

    return FutureBuilder<List<Buster>>(
      future: _panel ? getFriendsData() : getTopBustersData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final data = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final buster = data[index];
              return ListTile(
                title: Text(
                  buster.username,
                  style: const TextStyle(fontSize: 14),
                ),
                leading: profilePic(
                  buster.pfp,
                  50,
                  child: n.Text(buster.actualRank.toString())
                    ..fontSize = 16
                    ..w500
                    ..height = 0.8
                    ..freezed,
                ),
                trailing: n.Column([
                  n.Text("${buster.percentileRank}%")
                    ..fontSize = 14
                    ..freezed,
                  n.Text(t.less_than_avg)
                    ..fontSize = 8
                    ..freezed,
                ]),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
