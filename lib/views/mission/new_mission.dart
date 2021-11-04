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
        ],
      ),
    );
  }
}
