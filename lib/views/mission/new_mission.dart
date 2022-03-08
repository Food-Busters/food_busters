// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/hooks.dart";
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
    final t = useTranslation(context);

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("${t.mission} ($pageLabel)"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        Center(
          child: SingleChildScrollView(
            child: n.Column([
              missionBlock(t.eat_less, lightOrange),
              missionBlock(t.eat_more, lightGreen),
            ])
              ..mainCenter,
          ),
        ),
      ]),
    );
  }

  Widget missionBlock(String title, Color color) {
    final t = useTranslation(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: n.Column([
          Text(title),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: n.Column([
                missionButtons()..py = 8,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: n.Row([
                      Text(t.within),
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
                      Text(t.days),
                    ])
                      ..mainEvenly
                      ..p = 8,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(t.challenge_accepted),
                          backgroundColor: lightGreen,
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: n.Text(t.window_close)
                                ..color = Colors.black
                                ..freezed,
                            )
                          ],
                        ),
                      );
                    },
                    child: Text(t.i_can_do_this),
                    style: tanBtn,
                  ),
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }

  n.Row missionButtons() {
    return n.Row([
      ElevatedButton(
        onPressed: () {
          setState(() {
            selected = 0;
          });
        },
        child: Image.asset(
          "assets/images/foods/starch.webp",
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
          "assets/images/foods/meat.webp",
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
          "assets/images/foods/dessert.webp",
          height: 60,
        ),
        style: ElevatedButton.styleFrom(
          primary: selected == 2 ? lightGreen : lightOrange,
        ),
      ),
    ])
      ..mainEvenly;
  }
}
