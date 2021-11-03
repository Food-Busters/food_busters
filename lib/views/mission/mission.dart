import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_current_missions.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/mission.dart";
import "package:food_busters/styles/styles.dart";

class MyMissionPage extends StatefulWidget {
  const MyMissionPage({Key? key}) : super(key: key);

  @override
  _MyMissionPageState createState() => _MyMissionPageState();
}

class _MyMissionPageState extends State<MyMissionPage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.mission),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: currentMission(text),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: cravingMissions(text),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget currentMission(AppLocalizations text) => Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: const Color(0xFFFFCA66),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text(text.current_missions),
              FutureBuilder<List<OngoingMission>>(
                future: getCurrentMissions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    final data = snapshot.data!;
                    final loc = MyApp.of(context).localeStrSimp;
                    return SingleChildScrollView(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          final ms = data[index];
                          return ListTile(
                            title: Text(ms.obj.toStr(loc)),
                            trailing: Row(
                              children: [
                                Text(ms.deadlineDate.toString()),
                                Text(ms.deadlineMonth)
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )
            ],
          ),
        ),
      );

  Widget cravingMissions(AppLocalizations text) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: lightGreen,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(text.easy, style: const TextStyle(fontSize: 36)),
                  style: tanBtn,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(text.hard, style: const TextStyle(fontSize: 36)),
                  style: tanBtn,
                ),
              ),
            ],
          ),
        ),
      );
}
