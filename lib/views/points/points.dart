// 🐦 Flutter imports:
import "package:flutter/material.dart";

// 📦 Package imports:
import "package:flutter_toggle_tab/flutter_toggle_tab.dart";
import "package:food_busters/hooks.dart";
import "package:form_field_validator/form_field_validator.dart";
import "package:niku/namespace.dart" as n;

// 🌎 Project imports:
import "package:food_busters/components/background.dart";
import "package:food_busters/components/exchange_dialog.dart";
import "package:food_busters/main.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/points/exchange.dart";
import "package:food_busters/views/points/points_shop.dart";

class MyPoints extends StatefulWidget {
  const MyPoints({Key? key, this.showPremium}) : super(key: key);

  final bool? showPremium;

  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  late bool _panel;

  @override
  void initState() {
    super.initState();
    _panel = widget.showPremium ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final t = useTranslation(context);
    final appState = MyApp.of(context).state;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(t.my_points),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PointsShopPage()),
              );
              setState(() {});
            },
            child: const Icon(Icons.attach_money, color: green),
          )
        ],
      ),
      body: n.Stack([
        bgImage("clouds/bottom_aqua.webp"),
        bgImage("clouds/top_orange.webp"),
        n.Column([
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(200),
                color: Colors.transparent,
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                ),
              ),
              child: n.Column([
                n.Text(appState.points.toString())
                  ..fontSize = 64
                  ..w500
                  ..height = 1.6,
                n.Text(t.points)
                  ..fontSize = 36
                  ..height = 0.3
                  ..freezed,
              ]),
            ),
          ),
          const SizedBox(height: 30),
          FlutterToggleTab(
            width: 90,
            borderRadius: 30,
            height: 50,
            selectedIndex: _panel ? 1 : 0,
            selectedTextStyle: const TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
            unSelectedTextStyle: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            labels: [t.promotion, t.premium],
            selectedLabelIndex: (index) {
              setState(() {
                _panel = index == 0 ? false : true;
              });
            },
            selectedBackgroundColors: _panel ? [lightGreen] : [lightOrange],
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
            child: _panel ? exchangePremiumPanel() : promotionPanel(),
          ),
        ])
          ..center,
      ]),
    );
  }

  Widget promotionPanel() {
    final t = useTranslation(context);

    return Container(
      decoration: BoxDecoration(
        color: lightOrange,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: n.Row([
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: n.Column([
              const Icon(Icons.star),
              Text(t.for_you),
            ]),
            style: tanBtn,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExchangePage(),
                ),
              );
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: n.Column([
              const Icon(Icons.search),
              Text(t.search),
            ]),
            style: tanBtn,
            onPressed: () {
              final formKey = GlobalKey<FormState>();
              String searchQuery = "";
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: lightGreen,
                  title: n.Text(t.search.toUpperCase())
                    ..center
                    ..freezed,
                  content: Form(
                    key: formKey,
                    child: n.Column([
                      Text(t.search_message),
                      TextFormField(
                        validator: RequiredValidator(
                          errorText: t.search_query_empty,
                        ),
                        onSaved: (String? sQ) {
                          searchQuery = sQ ?? "";
                        },
                      ),
                    ])
                      ..min,
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(t.window_close),
                      style: ElevatedButton.styleFrom(primary: lightOrange),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          formKey.currentState?.save();
                          await Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ExchangePage(
                                searchQuery: searchQuery,
                              ),
                            ),
                          );
                          setState(() {});
                        }
                      },
                      child: Text(t.confirm),
                      style: ElevatedButton.styleFrom(primary: green),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ])
        ..mainCenter
        ..p = 8,
    );
  }

  Widget exchangePremiumPanel() {
    final state = MyApp.of(context).state;

    return Container(
      decoration: BoxDecoration(
        color: lightGreen,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: n.Row([
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: exchangePointsButtonLabel(150, 7),
            style: tanBtn,
            onPressed: () {
              final tscStatus = state.usePoints(150);
              if (tscStatus) {
                state.assignPremium();
              }
              showDialog(
                context: context,
                builder: (context) => tscStatus
                    ? exchangeSuccess(context)
                    : exchangeFailed(context),
              );
              setState(() {});
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: exchangePointsButtonLabel(289, 14),
            style: tanBtn,
            onPressed: () {
              final tscStatus = state.usePoints(289);
              if (tscStatus) {
                state.assignPremium();
              }
              showDialog(
                context: context,
                builder: (context) => tscStatus
                    ? exchangeSuccess(context)
                    : exchangeFailed(context),
              );
              setState(() {});
            },
          ),
        ),
      ])
        ..mainCenter
        ..p = 8,
    );
  }

  Widget exchangePointsButtonLabel(
    int points,
    int days,
  ) {
    final t = useTranslation(context);

    return n.Column([
      n.Text(t.n_days_pass.replaceAll("{n}", "$days"))
        ..fontSize = 22
        ..freezed,
      n.Text("$points")
        ..fontSize = 30
        ..color = green
        ..height = 1
        ..freezed,
      n.Text(t.points.toUpperCase())
        ..fontSize = 20
        ..color = green
        ..height = 1
        ..freezed,
      Text(t.press_to_exchange),
    ]);
  }
}
