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
                      return Row(
                        children: [
                          Container(
                            height: 50,
                            decoration: const BoxDecoration(color: lightGreen),
                            child: Text("${menu.points} ${text.points}"),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: Text("${menu.price} THB"),
                          ),
                        ],
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
