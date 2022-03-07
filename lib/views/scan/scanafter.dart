// 🎯 Dart imports:
import "dart:convert";
import "dart:io";

// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_dotenv/flutter_dotenv.dart";
import "package:http/http.dart" as http;
import "package:niku/namespace.dart" as n;
import "package:package_info_plus/package_info_plus.dart";
import "package:pie_chart/pie_chart.dart";
import "package:share_plus/share_plus.dart";

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/buttons.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/ml_error.dart";
import "package:food_busters/models/ml_result.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/scan/recommend_food.dart";

const internalError =
    "Internal Flutter Error, should NOT appear on production!";

class ScanAfterPage extends StatefulWidget {
  const ScanAfterPage({Key? key}) : super(key: key);

  @override
  _ScanAfterPageState createState() => _ScanAfterPageState();
}

class _ScanAfterPageState extends State<ScanAfterPage> {
  int percent = 0;
  int pointRecieved = 0;
  Map<String, double> foodData = {"undefined": 100};
  MLAPIResult? apiResult;
  Quote? quote;
  int successedPromise = 0;
  String? errorMessage;

  Future<void> setMLResult() async {
    final appState = MyApp.of(context).state;

    // * This should only happen when hot reload in this page.
    if (!appState.imageReady) {
      return;
    }

    final apiEndpoint = dotenv.env["API_ENDPOINT"];

    if (apiEndpoint == null) {
      errorMessage = "Internal App Error: env.API_ENDPOINT not set";
      return;
    }

    List<int> imageBytes = File(appState.imageBefore!.path).readAsBytesSync();
    String base64Image = "data:image/png;base64," + base64Encode(imageBytes);

    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    http.Response mlResponse;
    mlResponse = await http.post(
      Uri.parse(apiEndpoint),
      headers: {
        "Content-Type": "application/json",
        "version": "app-${packageInfo.version.split('.')[2]}",
      },
      body: jsonEncode({
        "modelType": "U",
        "image": base64Image,
      }),
    );

    if (mlResponse.statusCode >= 400) {
      final error = MLAPIError.fromRawJson(mlResponse.body);
      errorMessage = "${mlResponse.statusCode} ${error.message}";
      return;
    }

    apiResult = MLAPIResult.fromRawJson(mlResponse.body);
    foodData = apiResult!.foodNutrition.toJson();
    successedPromise++;
  }

  Future<void> setQuote() async {
    final appState = MyApp.of(context).state;

    // * This should only happen when hot reload in this page.
    if (!appState.imageReady) {
      errorMessage =
          "Image lost in state. You should not see this on production!";
      return;
    }

    percent = appState.percent;
    pointRecieved = (percent * percent / 100).floor();
    appState.addPoints(pointRecieved);
    appState.resetAllImages();

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote"
      "?percent=$percent&lang=${MyApp.of(context).localeStrSimp}",
    );

    http.Response response;
    try {
      response = await http.get(url);
    } catch (err) {
      errorMessage = "$err";
      return;
    }

    if (response.statusCode >= 400) {
      errorMessage = "${response.statusCode} ${response.body}";
      return;
    } else {
      final resobj = quoteFromJson(response.body);
      quote = resobj;
      successedPromise++;
      return;
    }
  }

  Future<void> fireAPI() async {
    final promise1 = setMLResult();
    final promise2 = setQuote();

    await promise1;
    await promise2;
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
          child: FutureBuilder<void>(
            future: fireAPI(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (successedPromise != 2) {
                  quote = Quote(
                    quote: errorMessage ?? internalError,
                  );
                }

                quote ??= Quote(quote: internalError);

                if (successedPromise != 2) {
                  return n.Column([infoPage1(), backHomeBtn(context)])
                    ..mainCenter;
                }

                return DefaultTabController(
                  length: 3,
                  child: TabBarView(
                    children: [
                      tabPageWrapper(infoPage1),
                      tabPageWrapper(infoPage2),
                      tabPageWrapper(infoPage3),
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
        backgroundColor: lightOrange,
        onPressed: () async {
          if (successedPromise != 2) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(t.cannot_share_loading),
              ),
            );
            return;
          }

          await Share.share(
            "Check my fabulous feasting out!\n"
            "Menu: ${apiResult!.foodName.get(context)}, "
            "Ate $percent% of the dish!\n"
            "This meal is also certified green and clean.",
          );
        },
      ),
    );
  }

  Widget tabPageWrapper(
    Widget Function() widget,
  ) {
    final t = useTranslation(context);

    return n.Column(
      [Text("—${t.swipe_hint}—"), widget(), backHomeBtn(context)],
    )..mainCenter;
  }

  Widget infoPage1() {
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
      Image.asset("assets/images/${toWebp(quote!.image)}", height: 200),
      n.Text(percent < 80 ? t.oh_no : t.wow)
        ..fontSize = 28
        ..freezed,
      n.Text(quote!.quote)
        ..fontSize = 24
        ..color = green
        ..center
        ..useParent((v) => v..p = 8),
    ])
      ..mainCenter;
  }

  Widget infoPage2() {
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

  Widget infoPage3() {
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
          centerText: apiResult?.foodName.get(context),
        ),
      ),
      n.Text(
        "${t.detected_by_sfc} "
        "${(apiResult!.confidence * 100).toStringAsFixed(2)}%",
      )
        ..center
        ..w500
        ..freezed,
      Text(t.take_home_recommendation),
      const SizedBox(height: 16),
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
