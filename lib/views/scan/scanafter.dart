// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:food_busters/hooks.dart";
import "package:http/http.dart" as http;
import "package:niku/namespace.dart" as n;
import "package:pie_chart/pie_chart.dart";
import "package:share_plus/share_plus.dart";

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/buttons.dart";
import "package:food_busters/data/food_data.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/models/state/app_state.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/scan/recommend_food.dart";

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
  Food food = Food.chicken;

  Map<String, double> foodData = {};

  Future<Quote> getAnalysis(BuildContext context) async {
    final appState = MyApp.of(context).state;
    if (!appState.imageReady) {
      return Quote(quote: "Image lost in state");
    }

    // * SIMULATE IMAGE PROCESSING
    // await Future.delayed(const Duration(milliseconds: 500));
    percent = appState.percent;
    food = appState.menu;

    pointRecieved = (percent * percent / 100).floor();
    appState.addPoints(pointRecieved);

    appState.resetAllImages();

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=$percent&lang=${MyApp.of(context).localeStrSimp}",
    );

    foodData = await getChickenRiceData();

    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      return Quote(quote: "$err");
    }

    if (response.statusCode >= 400) {
      return Quote(quote: "${response.statusCode} ${response.body}");
    } else {
      final resobj = quoteFromJson(response.body);
      return resobj;
    }
  }

  String toWebp(String name) {
    var tokens = name.split(".");
    tokens.removeLast();
    return tokens.join(".") + ".webp";
  }

  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.scan_result),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        Center(
          child: FutureBuilder<Quote>(
            future: getAnalysis(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final quote =
                    snapshot.data ?? Quote(quote: "Internal Flutter Error");
                return DefaultTabController(
                  length: 3,
                  child: TabBarView(
                    children: [
                      tabPageWrapper(infoPage1, quote),
                      tabPageWrapper(infoPage2, quote),
                      tabPageWrapper(infoPage3, quote),
                    ],
                  ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () async {
          await Share.share(
            "Check my fabulous feasting out!\n"
            "This meal is also certified green and clean.",
          );
        },
      ),
    );
  }

  Widget tabPageWrapper(
    Widget Function(Quote quote) widget,
    Quote quote,
  ) {
    final t = useTranslation(context);

    return n.Column(
      [Text("—${t.swipe_hint}—"), widget(quote), backHomeBtn(context)],
    )..mainCenter;
  }

  Widget infoPage1(Quote quote) {
    final t = useTranslation(context);

    return n.Column([
      n.Text("+$pointRecieved ${t.points}")
        ..color = green
        ..fontSize = 30
        ..w500
        ..freezed,
      Text(
        "${t.you_have_eaten}"
        "${percent < 40 ? t.sp_only : ""} "
        "$percent% ${t.of_the_dish}...",
      ),
      Image.asset("assets/images/${toWebp(quote.image)}", height: 200),
      n.Text(percent < 80 ? t.oh_no : t.wow)
        ..fontSize = 28
        ..freezed,
      n.Text(quote.quote)
        ..fontSize = 24
        ..color = green
        ..center
        ..useParent((v) => v..p = 8),
    ])
      ..mainCenter;
  }

  Widget infoPage2(Quote quote) {
    final t = useTranslation(context);

    return n.Column([
      Image.asset("assets/images/money.webp", width: 150, height: 150),
      n.Text("${50 - percent / 2} THB")
        ..color = green
        ..fontSize = 26
        ..w500
        ..freezed,
      n.Text(t.save_money_1)
        ..fontSize = 22
        ..w500
        ..freezed,
      n.Text(t.save_money_2)
        ..fontSize = 18
        ..freezed,
    ])
      ..mainCenter;
  }

  Widget infoPage3(Quote quote) {
    final t = useTranslation(context);

    return n.Column([
      n.Text(t.your_data)
        ..fontSize = 28
        ..w500
        ..freezed,
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 24.0),
        child: PieChart(
          dataMap: foodData,
          chartType: ChartType.ring,
          centerText: food == Food.chicken ? t.chicken : t.omelet,
        ),
      ),
      Text(t.take_home_recommendation),
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const RecommendFoodPage(),
            ),
          );
        },
        child: Text(t.any_menu_suits_me),
        style: greenBtn,
      ),
    ])
      ..p = 16;
  }
}
