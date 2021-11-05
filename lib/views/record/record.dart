import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_record.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/app_state.dart";
import "package:food_busters/models/food_record.dart";
import "package:food_busters/styles/styles.dart";
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
    final text = AppLocalizations.of(context)!;
    final appState = MyApp.of(context).state;

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
          bgImage("clouds/top_orange.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(32.0),
                child: recordHeader(text),
              ),
              foodChart(text),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: btnGroup(context, text, appState),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget recordHeader(AppLocalizations text) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(text.record_header_1),
                  Text(
                    " $foodwaste kg",
                    style: const TextStyle(
                      color: green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Text(text.record_header_2),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(text.record_header_3),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "$lessmethane% ",
                    style: const TextStyle(
                      color: green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(text.record_header_4),
                ],
              ),
            ],
          ),
        ],
      );

  Widget foodChart(AppLocalizations text) => Column(
        children: [
          Text(
            "${text.what_you_eaten}...",
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: FutureBuilder<FoodRecord>(
              future: getFoodRecord(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final record = snapshot.data!;
                  final tiles = <Widget>[];

                  tiles.addAll(
                    [
                      bigFoodTile(context, "vegetable", record.vegetable),
                      bigFoodTile(context, "meat", record.meat),
                      bigFoodTile(context, "starch", record.starch),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child:
                                smallFoodTile(context, "fruit", record.fruit),
                          ),
                          Expanded(
                            flex: 1,
                            child: smallFoodTile(
                              context,
                              "dessert",
                              record.dessert,
                            ),
                          ),
                        ],
                      ),
                    ],
                  );

                  return Column(
                    children: tiles,
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      );

  Widget bigFoodTile(BuildContext context, String label, int percent) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
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
                child: const Text(""),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/foods/$label.png", height: 50),
                Text("$percent%", style: const TextStyle(height: 2.5)),
              ],
            ),
          ],
        ),
      );

  Widget smallFoodTile(
    BuildContext context,
    String label,
    int percent,
  ) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Stack(
          children: [
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset("assets/images/foods/$label.png", height: 50),
                Text("$percent%"),
              ],
            ),
          ],
        ),
      );

  Widget btnGroup(
    BuildContext context,
    AppLocalizations text,
    AppState state,
  ) =>
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                    title: Text(text.oops),
                    content: Text(text.premium_only),
                    backgroundColor: rose,
                    actions: [
                      TextButton(
                        child: Text(
                          text.what_is_premium,
                          style: const TextStyle(color: green),
                        ),
                        onPressed: () {},
                      ),
                      TextButton(
                        child: Text(text.window_close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                );
              }
            },
            child: Text(text.health_status),
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
            child: Text(text.other_busters),
            style: lightOrangeBtn,
          ),
        ],
      );
}
