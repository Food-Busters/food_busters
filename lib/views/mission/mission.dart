// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_current_missions.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/models/mission.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/mission/new_mission.dart";

class MyMissionPage extends StatefulWidget {
  const MyMissionPage({Key? key}) : super(key: key);

  @override
  _MyMissionPageState createState() => _MyMissionPageState();
}

class _MyMissionPageState extends State<MyMissionPage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.mission),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.webp"),
        bgImage("clouds/top_orange.webp"),
        n.Column([
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: currentMission(),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: cravingMissions(),
          ),
        ])
          ..mainCenter,
      ]),
    );
  }

  Widget currentMission() {
    final t = useTranslation(context);

    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color(0xFFFFCA66),
      ),
      child: n.Column([
        Text(t.current_missions),
        Container(
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: FutureBuilder<List<OngoingMission>>(
            future: getCurrentMissions(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!;
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final ms = data[index];
                    return ListTile(
                      title: n.Column([
                        Text(ms.obj.get(context)),
                        Text(
                          "${ms.award.toString()} ${t.points}",
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ]),
                      trailing: n.Column([
                        n.Text(ms.deadlineDate.toString())
                          ..fontSize = 24
                          ..w500
                          ..height = 1
                          ..freezed,
                        n.Text(ms.deadlineMonth)
                          ..fontSize = 12
                          ..height = 0.5
                          ..freezed,
                      ])
                        ..mainCenter,
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 1.5,
                    color: Colors.grey,
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        )
      ])
        ..p = 16,
    );
  }

  Widget cravingMissions() {
    final t = useTranslation(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: lightGreen,
      ),
      child: n.Column([
        Text(t.craving_missions),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          child: n.Row([
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewMissionPage(
                        missionType: MissionType.food,
                      ),
                    ),
                  );
                },
                child: n.Text("FOOD")
                  ..fontSize = 24
                  ..freezed,
                style: tanBtn,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NewMissionPage(
                        missionType: MissionType.carbonFoodprint,
                      ),
                    ),
                  );
                },
                child: n.Text("CARBON FOOTPRINT")
                  ..fontSize = 16
                  ..freezed,
                style: tanBtn,
              ),
            ),
          ])
            ..mainBetween,
        ),
        n.Text(t.hard_missions_desc)
          ..fontSize = 12
          ..center
          ..freezed,
      ])
        ..p = 16,
    );
  }
}
