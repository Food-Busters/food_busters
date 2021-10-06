import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";

class PollutionInfo extends StatefulWidget {
  const PollutionInfo({Key? key, required this.percent}) : super(key: key);

  final int percent;

  @override
  _PollutionInfoState createState() => _PollutionInfoState();
}

class _PollutionInfoState extends State<PollutionInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Learn more"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("assets/images/clouds/top_orange.png"),
          Center(
            child: Text(
              "Pollution produced is ${(100 - widget.percent) * 10} grams of CO2!",
            ),
          ),
        ],
      ),
    );
  }
}
