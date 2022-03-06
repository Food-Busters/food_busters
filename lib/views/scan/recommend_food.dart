// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:food_busters/hooks.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/green_leaves.dart";
import "package:food_busters/data/dummy_restaurant.dart";
import "package:food_busters/models/restaurant_menu.dart";

class RecommendFoodPage extends StatefulWidget {
  const RecommendFoodPage({Key? key}) : super(key: key);

  @override
  _RecommendFoodPageState createState() => _RecommendFoodPageState();
}

class _RecommendFoodPageState extends State<RecommendFoodPage> {
  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);

    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.recommended),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: n.Stack([
        bgImage("clouds/top_orange.webp"),
        FutureBuilder<List<RestaurantMenu>>(
          future: getRestaurantData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List<RestaurantMenu> data = snapshot.data!;
              data = data
                  .where((res) => res.cheaper > 0 && res.lessCarbon > 0)
                  .toList();

              List<Widget> menuTabs = [];

              for (int i = 0; i < data.length; i++) {
                final menu = data[i];

                menuTabs.add(
                  n.Column([
                    n.Text("${menu.match}% match")
                      ..fontSize = 26
                      ..freezed,
                    n.Row([
                      n.Text(i == 0 ? " " : "<")
                        ..fontSize = 32
                        ..w500
                        ..freezed,
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              menu.menuPicture,
                            ),
                          ),
                        ),
                      ),
                      n.Text(i == data.length - 1 ? " " : ">")
                        ..fontSize = 32
                        ..w500
                        ..freezed,
                    ])
                      ..mainEvenly,
                    Text(menu.menuName),
                    Text(menu.restaurantName),
                    n.Row(bigGreenLeaves(menu.healthiness))..mainCenter,
                    n.Row([
                      Expanded(
                        flex: 1,
                        child: n.Column([
                          Text("${menu.cheaper}%"),
                          Text(t.food_cheaper),
                        ])
                          ..crossEnd,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                        ),
                        child: Container(
                          width: 2,
                          height: 100,
                          color: Colors.black,
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${menu.lessCarbon}%"),
                            Text(t.food_less_carbon),
                          ],
                        ),
                      ),
                    ])
                      ..mainCenter,
                  ])
                    ..mainCenter,
                );
              }

              return DefaultTabController(
                length: data.length,
                child: TabBarView(
                  children: menuTabs,
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
}
