import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/scan/pollution_info.dart";
import "package:http/http.dart" as http;
import "package:flutter_gen/gen_l10n/app_localizations.dart";

// ! Temporary, as in production we don't random user's result
import "dart:math";

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({Key? key, required this.image}) : super(key: key);

  final XFile image;

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  void initState() {
    super.initState();
  }

  int percent = 0;

  Future<String> getQuote() async {
    // * SIMULATE IMAGE PROCESSING
    await Future.delayed(const Duration(milliseconds: 500));
    percent = Random().nextInt(100) + 1;

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=${percent}&lang=${MyApp.of(context).localeStrSimp}",
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
              future: getQuote(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final isBad = percent < 80;
                  final quote = snapshot.data ?? "Impossible Error";
                  return Column(
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
                        "${text.you_have_eaten}${percent < 40 ? text.sp_only : ""} "
                        "$percent% ${text.of_the_dish}...",
                      ),
                      Text(
                        isBad ? text.oh_no : text.wow,
                        style: const TextStyle(fontSize: 28),
                      ),
                      Text(
                        quote,
                        style: const TextStyle(fontSize: 24, color: green),
                        textAlign: TextAlign.center,
                      ),
                    ],
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
}
