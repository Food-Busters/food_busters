import "package:flutter/material.dart";
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import "package:food_busters/components/background.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";

class MyPoints extends StatefulWidget {
  const MyPoints({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4E4D8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("MY POINTS"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Colors.transparent,
                    border: Border.all(
                      width: 2,
                      color: Colors.black,
                    ),
                  ),
                  child: Column(
                    children: [
                      const Text(
                        "18",
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        text.points,
                        style: const TextStyle(
                          fontSize: 36,
                          height: 0.3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              FlutterToggleTab(
                width: 90,
                borderRadius: 30,
                height: 50,
                selectedIndex: 0,
                selectedTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
                unSelectedTextStyle: const TextStyle(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                labels: [text.promotion, text.premium],
                selectedLabelIndex: (index) {
                  if (index == 1) {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) => AlertDialog(
                        title: Text(text.oops, textAlign: TextAlign.center),
                        content: Text(text.premium_only),
                        backgroundColor: const Color(0xFFBBDFC8),
                        actions: [
                          TextButton(
                            child: Text(
                              "✨ " + text.what_is_premium,
                              style: TextStyle(
                                color: Colors.yellow.shade900,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text(
                              text.window_close,
                              style: const TextStyle(color: Colors.black),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
