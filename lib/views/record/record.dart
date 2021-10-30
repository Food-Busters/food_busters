import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/app_state.dart";
import "package:food_busters/styles/styles.dart";
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
              btnGroup(context, text, appState),
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
                  Text(" $foodwaste kg", style: const TextStyle(color: green)),
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
                  Text("$lessmethane% ", style: const TextStyle(color: green)),
                  Text(text.record_header_4),
                ],
              ),
            ],
          ),
        ],
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
                // TODO smth
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
