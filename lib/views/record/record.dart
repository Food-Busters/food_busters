// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_record.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/food_record.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/points/points.dart";
import "package:food_busters/views/record/health_status.dart";
import "package:food_busters/views/record/other_busters.dart";

class MyRecordPage extends StatefulWidget {
  const MyRecordPage({Key? key}) : super(key: key);

  @override
  _MyRecordPageState createState() => _MyRecordPageState();
}

class _MyRecordPageState extends State<MyRecordPage> {
  int foodwaste = 20;
  int lessmethane = 45;

  @override
  Widget build(BuildContext context) {
    final text = useTranslation(context);

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.my_record),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        n.Column([
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: recordHeader(),
          ),
          foodChart(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: btnGroup(),
          ),
        ])
          ..mainCenter,
      ]),
    );
  }

  Widget recordHeader() {
    final t = useTranslation(context);

    return n.Column([
      n.Column([
        n.Row([
          Text(t.record_header_1),
          n.Text(" $foodwaste kg")
            ..color = green
            ..w500
            ..freezed,
        ])
          ..mainStart,
        Text(t.record_header_2),
      ])
        ..crossStart,
      n.Column([
        Text(t.record_header_3),
        n.Row([
          n.Text("$lessmethane% ")
            ..color = green
            ..w500
            ..freezed,
          Text(t.record_header_4),
        ])
          ..mainEnd,
      ])
        ..crossEnd,
    ])
      ..mainCenter;
  }

  Widget foodChart() {
    final t = useTranslation(context);

    return n.Column([
      n.Text("${t.what_you_eaten}...")
        ..fontSize = 25
        ..w500
        ..freezed,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: FutureBuilder<FoodRecord>(
          future: getFoodRecord(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final record = snapshot.data!;
              final tiles = <Widget>[];

              tiles.addAll([
                bigFoodTile("vegetable", record.vegetable),
                bigFoodTile("meat", record.meat),
                bigFoodTile("starch", record.starch),
                n.Row([
                  Expanded(
                    flex: 1,
                    child: smallFoodTile("fruit", record.fruit),
                  ),
                  Expanded(
                    flex: 1,
                    child: smallFoodTile(
                      "dessert",
                      record.dessert,
                    ),
                  ),
                ])
                  ..mainBetween,
              ]);

              return Column(
                children: tiles,
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    ]);
  }

  Widget bigFoodTile(String label, int percent) {
    return n.Stack([
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 12.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * percent / 100,
          height: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: lightOrange,
          ),
        ),
      ),
      n.Row([
        Image.asset("assets/images/foods/$label.webp", height: 50),
        n.Text("$percent%")
          ..height = 2.5
          ..freezed
      ])
        ..mainStart,
    ])
      ..useParent((v) => v..px = 16);
  }

  Widget smallFoodTile(
    String label,
    int percent,
  ) {
    return n.Stack([
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
          vertical: 12.0,
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * percent / 100,
          height: 28,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6.0),
            color: Colors.grey,
          ),
          child: const Text(""),
        ),
      ),
      n.Row([
        Image.asset("assets/images/foods/$label.webp", height: 50),
        Text("$percent%"),
      ])
        ..mainStart,
    ])
      ..useParent((v) => v..px = 16);
  }

  Widget btnGroup() {
    final t = useTranslation(context);
    final state = MyApp.of(context).state;

    return n.Row([
      ElevatedButton(
        onPressed: () {
          if (state.isPremiumUser) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HealthStatusPage(),
              ),
            );
          } else {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(t.oops),
                content: Text(t.premium_only),
                backgroundColor: rose,
                actions: [
                  TextButton(
                    child: n.Text(t.what_is_premium)
                      ..color = green
                      ..freezed,
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const MyPoints(showPremium: true),
                        ),
                      );
                    },
                  ),
                  TextButton(
                    child: Text(t.window_close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
        child: Text(t.health_status),
        style: greenBtn,
      ),
      const SizedBox(width: 16.0),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OtherBustersPage(),
            ),
          );
        },
        child: Text(t.other_busters),
        style: lightOrangeBtn,
      ),
    ])
      ..mainCenter;
  }
}
