import "package:flutter/material.dart";
import "package:flutter_gen/gen_l10n/app_localizations.dart";
import "package:food_busters/components/background.dart";

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
        ],
      ),
    );
  }
}
