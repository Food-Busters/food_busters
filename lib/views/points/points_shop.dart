import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_points.dart";
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
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.points_shop),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
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
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: lightGreen,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${menu.points} ${text.points}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 22,
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(text.purchase_success),
                                    content: Text(text.purchase_thanks),
                                    backgroundColor: lightGreen,
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text(text.window_close),
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
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
