import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/styles/styles.dart";
import "package:http/http.dart" as http;
import "package:flutter_gen/gen_l10n/app_localizations.dart";

// ! Temporary, as in production we don't random user's result
import "dart:math";

class ScanAfterPage extends StatefulWidget {
  const ScanAfterPage({Key? key}) : super(key: key);

  @override
  _ScanAfterPageState createState() => _ScanAfterPageState();
}

class _ScanAfterPageState extends State<ScanAfterPage> {
  @override
  void initState() {
    super.initState();
  }

  int percent = 0;

  Future<String> getAnalysis(BuildContext context) async {
    final appState = MyApp.of(context).state;
    if (!appState.imageReady) {
      return "Image lost in state";
    }

    // * SIMULATE IMAGE PROCESSING
    await Future.delayed(const Duration(milliseconds: 500));
    percent = Random().nextInt(100) + 1;

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=$percent&lang=${MyApp.of(context).localeStrSimp}",
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      return "${response.statusCode} ${response.body}";
    } else {
      final resobj = quoteFromJson(response.body);
      return resobj.quote;
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.scan_result),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/top_orange.png"),
          Center(
            child: FutureBuilder<String>(
              future: getAnalysis(context),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final quote = snapshot.data ?? "Internal Flutter Error";
                  return DefaultTabController(
                    length: 2,
                    child: TabBarView(
                      children: [
                        infoPage1(text, quote),
                        infoPage2(text),
                      ],
                    ),
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () {},
      ),
    );
  }

  Widget infoPage1(AppLocalizations text, String quote) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${(percent * percent / 100).floor()} ${text.points}",
            style: const TextStyle(
              color: green,
              fontSize: 30,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "${text.you_have_eaten}"
            "${percent < 40 ? text.sp_only : ""} "
            "$percent% ${text.of_the_dish}...",
          ),
          Text(
            percent < 80 ? text.oh_no : text.wow,
            style: const TextStyle(fontSize: 28),
          ),
          Text(
            quote,
            style: const TextStyle(fontSize: 24, color: green),
            textAlign: TextAlign.center,
          ),
        ],
      );

  Widget infoPage2(AppLocalizations text) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/images/money.png", width: 150, height: 150),
          Text(
            "${50 - percent / 2} THB",
            style: const TextStyle(
              color: green,
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text.save_money_1,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            text.save_money_2,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      );
}
