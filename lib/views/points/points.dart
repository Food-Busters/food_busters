import "package:flutter/material.dart";
import "package:flutter_toggle_tab/flutter_toggle_tab.dart";
import "package:food_busters/components/background.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/styles/styles.dart";
import "package:food_busters/views/points/exchange.dart";
import "package:food_busters/views/points/points_shop.dart";
import "package:form_field_validator/form_field_validator.dart";

class MyPoints extends StatefulWidget {
  const MyPoints({Key? key, required this.userID}) : super(key: key);

  final String userID;

  @override
  _MyPointsState createState() => _MyPointsState();
}

class _MyPointsState extends State<MyPoints> {
  bool _panel = false;

  @override
  Widget build(BuildContext context) {
    final text = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: tan,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(text.my_points),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PointsShopPage()),
              );
            },
            child: const Icon(Icons.attach_money, color: green),
          )
        ],
      ),
      body: Stack(
        children: [
          bgImage("clouds/bottom_aqua.png"),
          bgImage("clouds/top_orange.png"),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                  child: Column(
                    children: [
                      const Text(
                        "18",
                        style: TextStyle(
                          fontSize: 100,
                          fontWeight: FontWeight.w500,
                          height: 1.2,
                        ),
                      ),
                      Text(
                        text.points,
                        style: const TextStyle(
                          fontSize: 36,
                          height: 0.3,
                        ),
                      ),
                    ],
                  ),
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
                labels: [text.promotion, text.premium],
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
                child:
                    _panel ? exchangePremiumPanel(text) : promotionPanel(text),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget promotionPanel(AppLocalizations text) => Container(
        decoration: BoxDecoration(
          color: lightOrange,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: Column(
                    children: [
                      const Icon(Icons.star),
                      Text(text.for_you),
                    ],
                  ),
                  style: tanBtn,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ExchangePage(
                          userID: widget.userID,
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: Column(
                    children: [
                      const Icon(Icons.search),
                      Text(text.search),
                    ],
                  ),
                  style: tanBtn,
                  onPressed: () {
                    final formKey = GlobalKey<FormState>();
                    String searchQuery = "";
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      builder: (context) => AlertDialog(
                        backgroundColor: lightGreen,
                        title: Text(
                          text.search.toUpperCase(),
                          textAlign: TextAlign.center,
                        ),
                        content: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(text.search_message),
                              TextFormField(
                                validator: RequiredValidator(
                                  errorText: text.search_query_empty,
                                ),
                                onSaved: (String? sQ) {
                                  searchQuery = sQ ?? "";
                                },
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(text.window_close),
                            style:
                                ElevatedButton.styleFrom(primary: lightOrange),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (formKey.currentState?.validate() ?? false) {
                                formKey.currentState?.save();
                                Navigator.of(context).pop();
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExchangePage(
                                      userID: widget.userID,
                                      searchQuery: searchQuery,
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(text.confirm),
                            style: ElevatedButton.styleFrom(primary: green),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget exchangePremiumPanel(AppLocalizations text) => Container(
        decoration: BoxDecoration(
          color: lightGreen,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: exchangePointsButtonLabel(text, 150, 7),
                  style: tanBtn,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => exchangeSuccess(text, context),
                    );
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  child: exchangePointsButtonLabel(text, 299, 14),
                  style: tanBtn,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => exchangeSuccess(text, context),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );

  Widget exchangePointsButtonLabel(
    AppLocalizations text,
    int points,
    int days,
  ) =>
      Column(
        children: [
          Text(
            text.n_days_pass.replaceAll("{n}", "$days"),
            style: const TextStyle(fontSize: 22),
          ),
          Text(
            "$points",
            style: const TextStyle(color: green, fontSize: 30, height: 1),
          ),
          Text(
            text.points.toUpperCase(),
            style: const TextStyle(color: green, fontSize: 20, height: 1),
          ),
          Text(text.press_to_exchange),
        ],
      );

  AlertDialog exchangeSuccess(AppLocalizations text, BuildContext context) =>
      AlertDialog(
        title: Text(text.exchange.toUpperCase(), textAlign: TextAlign.center),
        backgroundColor: lightGreen,
        content: Text(text.exchange_complete),
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
}
