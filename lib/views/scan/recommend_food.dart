import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
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
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.recommended),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("clouds/top_orange.png"),
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
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${menu.match}% match",
                          style: const TextStyle(fontSize: 26),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              i == 0 ? " " : "<",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
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
                            Text(
                              i == data.length - 1 ? " " : ">",
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        Text(menu.menuName),
                        Text(menu.restaurantName),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: bigGreenLeaves(menu.healthiness),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text("${menu.cheaper}%"),
                                  Text(text.food_cheaper),
                                ],
                              ),
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
                                  Text(text.food_less_carbon),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
        ],
      ),
    );
  }
}
