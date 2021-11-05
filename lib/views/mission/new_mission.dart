import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/styles/styles.dart";

enum MissionType {
  food,
  carbonFoodprint,
}

class NewMissionPage extends StatefulWidget {
  const NewMissionPage({Key? key, required this.missionType}) : super(key: key);

  final MissionType missionType;

  @override
  _NewMissionPageState createState() => _NewMissionPageState();
}

class _NewMissionPageState extends State<NewMissionPage> {
  late final String pageLabel;

  @override
  void initState() {
    super.initState();

    pageLabel = widget.missionType == MissionType.food ? "Food" : "Carbon";
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${text.mission} ($pageLabel)"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/top_orange.png"),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  missionBlock(text, text.eat_less, lightOrange),
                  missionBlock(text, text.eat_more, lightGreen),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget missionBlock(AppLocalizations text, String title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Text(title),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: missionButtons(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(text.within),
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: TextField(
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Text(text.days),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(text.challenge_accepted),
                              backgroundColor: lightGreen,
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    text.window_close,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        child: Text(text.i_can_do_this),
                        style: tanBtn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget missionButtons() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                selected = 0;
              });
            },
            child: Image.asset(
              "assets/images/foods/starch.png",
              height: 60,
            ),
            style: ElevatedButton.styleFrom(
              primary: selected == 0 ? lightGreen : lightOrange,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selected = 1;
              });
            },
            child: Image.asset(
              "assets/images/foods/meat.png",
              height: 60,
            ),
            style: ElevatedButton.styleFrom(
              primary: selected == 1 ? lightGreen : lightOrange,
            ),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                selected = 2;
              });
            },
            child: Image.asset(
              "assets/images/foods/dessert.png",
              height: 60,
            ),
            style: ElevatedButton.styleFrom(
              primary: selected == 2 ? lightGreen : lightOrange,
            ),
          ),
        ],
      );
}
