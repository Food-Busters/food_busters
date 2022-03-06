// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:food_busters/hooks.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_points.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/points_price.dart";
import "package:food_busters/styles/styles.dart";

class PointsShopPage extends StatefulWidget {
  const PointsShopPage({Key? key}) : super(key: key);

  @override
  _PointsShopPageState createState() => _PointsShopPageState();
}

class _PointsShopPageState extends State<PointsShopPage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.points_shop),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.webp"),
        bgImage("clouds/top_orange.webp"),
        Center(
          child: FutureBuilder<List<PointsPrice>>(
            future: getPointsPriceData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final data = snapshot.data!;
                return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final menu = data[index];
                    return n.Row([
                      Container(
                        height: 50,
                        decoration: BoxDecoration(
                          color: lightGreen,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: n.Text("${menu.points} ${t.points}")
                          ..fontSize = 22
                          ..w500
                          ..useParent((v) => v..p = 8)
                          ..freezed,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          appState.addPoints(menu.points);
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text(t.purchase_success),
                              content: Text(t.purchase_thanks),
                              backgroundColor: lightGreen,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(t.window_close),
                                  style: ElevatedButton.styleFrom(
                                    primary: lightOrange,
                                  ),
                                )
                              ],
                            ),
                          );
                        },
                        child: Text("${menu.price} THB"),
                        style: ElevatedButton.styleFrom(
                          primary: lightOrange,
                        ),
                      ),
                    ])
                      ..mainBetween
                      ..p = 16;
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        )
      ]),
    );
  }
}
