// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/exchange_dialog.dart";
import "package:food_busters/components/green_leaves.dart";
import "package:food_busters/components/profile_picture.dart";
import "package:food_busters/data/dummy_restaurant.dart";
import "package:food_busters/hooks.dart";
import "package:food_busters/main.dart";
import "package:food_busters/models/restaurant_menu.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/utils/string.dart";

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key, this.searchQuery}) : super(key: key);

  final String? searchQuery;

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      backgroundColor: const Color(0xFFF4E4D8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.my_points),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          n.Text("${appState.points} ${t.points}")..useParent((v) => v..p = 16)
        ],
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        FutureBuilder<List<RestaurantMenu>>(
          future: getRestaurantData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<RestaurantMenu> data = snapshot.data!;
              final sQuery = widget.searchQuery;
              if (sQuery != null) {
                final query = trimStr(sQuery);
                data = data
                    .where(
                      (res) =>
                          trimStr(res.menuName).contains(query) ||
                          trimStr(res.restaurantName).contains(query),
                    )
                    .toList();
              }

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: data.isNotEmpty
                    ? foodList(data)
                    : Center(
                        child: n.Text(t.no_data_found)
                          ..fontSize = 20
                          ..w500
                          ..freezed,
                      ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ]),
    );
  }

  Widget foodList(
    List<RestaurantMenu> data,
  ) {
    final t = useTranslation(context);
    final state = MyApp.of(context).state;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final res = data[index];
        return n.Column([
          n.Row([
            Column(
              children: [
                profilePic(res.menuPicture, 100),
                Row(children: greenLeaves(res.healthiness)),
              ],
            ),
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFBBDFC8),
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: n.Column([
                  Text(res.menuName),
                  Text(res.restaurantName),
                  Text("${res.price} THB"),
                  Text("${res.points} ${t.points}"),
                ]),
              ),
            )
          ])
            ..mainBetween
            ..px = 30
            ..py = 10,
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(300, 30),
              primary: lightOrange,
              padding: const EdgeInsets.symmetric(vertical: 6.0),
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return state.usePoints(res.points)
                      ? exchangeSuccess(context, showQR: true)
                      : exchangeFailed(context);
                },
              );
              setState(() {});
            },
            child: Text(t.exchange),
          ),
        ]);
      },
    );
  }
}
