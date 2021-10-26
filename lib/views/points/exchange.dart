import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/data/dummy_restaurant.dart";
import "package:food_busters/models/restaurant_menu.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/utils/string.dart";

class ExchangePage extends StatefulWidget {
  const ExchangePage({Key? key, required this.userID, this.searchQuery})
      : super(key: key);

  final String userID;
  final String? searchQuery;

  @override
  _ExchangePageState createState() => _ExchangePageState();
}

class _ExchangePageState extends State<ExchangePage> {
  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFFF4E4D8),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.my_points),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text("18 ${text.points}"),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
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
                      ? foodList(data, text)
                      : Center(
                          child: Text(
                            text.no_data_found,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
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

  Widget foodList(List<RestaurantMenu> data, AppLocalizations text) =>
      ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final res = data[index];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                res.menuPicture,
                              ),
                            ),
                          ),
                        ),
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
                        child: Column(
                          children: [
                            Text(res.menuName),
                            Text(res.restaurantName),
                            Text("${res.price} THB"),
                            Text(
                              "${res.points} ${text.points}",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
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
                      // * Do Something
                      return AlertDialog(
                        title: Text(text.exchange.toUpperCase()),
                        content: Text(text.exchange_complete),
                        backgroundColor: const Color(0xFFBBDFC8),
                        actions: [
                          TextButton(
                            child: Text(
                              text.window_close,
                              style: const TextStyle(
                                color: Colors.black,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(text.exchange),
              ),
            ],
          );
        },
      );

  List<Widget> greenLeaves(int count) {
    List<Widget> widgets = [];
    for (int i = 0; i < count; i++) {
      widgets.add(leaf);
    }
    return widgets;
  }
}

final leaf = Container(
  height: 100,
  width: 100,
  decoration: const BoxDecoration(
    shape: BoxShape.rectangle,
    image: DecorationImage(
      fit: BoxFit.cover,
      image: AssetImage("assets/images/leaf.png"),
    ),
  ),
);
