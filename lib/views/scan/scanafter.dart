import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/components/buttons.dart";
import "package:food_busters/data/food_data.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/scan/recommend_food.dart";
import "package:http/http.dart" as http;
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:pie_chart/pie_chart.dart";

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
  int pointRecieved = 0;

  Map<String, double> foodData = {};

  Future<String> getAnalysis(BuildContext context) async {
    final appState = MyApp.of(context).state;
    if (!appState.imageReady) {
      return "Image lost in state";
    }

    // * SIMULATE IMAGE PROCESSING
    await Future.delayed(const Duration(milliseconds: 500));
    percent = Random().nextInt(100) + 1;
    pointRecieved = (percent * percent / 100).floor();
    appState.addPoints(pointRecieved);

    appState.resetAllImages();

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=$percent&lang=${MyApp.of(context).localeStrSimp}",
    );
    final response = await http.get(url);

    foodData = await getChickenRiceData();

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
                    length: 3,
                    child: TabBarView(
                      children: [
                        tabPageWrapper(infoPage1, context, text, quote),
                        tabPageWrapper(infoPage2, context, text, quote),
                        tabPageWrapper(infoPage3, context, text, quote),
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

  Widget tabPageWrapper(
    Function widget,
    BuildContext context,
    AppLocalizations text,
    String quote,
  ) =>
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("—${text.swipe_hint}—"),
          widget(text, quote),
          backHomeBtn(context, text)
        ],
      );

  Widget infoPage1(AppLocalizations text, String quote) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$pointRecieved ${text.points}",
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

  Widget infoPage2(AppLocalizations text, String quote) => Column(
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

  Widget infoPage3(AppLocalizations text, String quote) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              text.your_data,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24.0),
              child: PieChart(
                dataMap: foodData,
                chartType: ChartType.ring,
              ),
            ),
            Text(text.take_home_recommendation),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RecommendFoodPage(),
                  ),
                );
              },
              child: Text(text.any_menu_suits_me),
              style: greenBtn,
            ),
          ],
        ),
      );
}
