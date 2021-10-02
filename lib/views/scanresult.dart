import "package:flutter/material.dart";
import "package:food_busters/models/quote.dart";
import "package:http/http.dart" as http;

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({Key? key, required this.percent}) : super(key: key);

  final int percent;

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  String quote = "Loading...";

  @override
  void initState() {
    super.initState();
    setQuote();
  }

  Future<void> setQuote() async {
    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=${widget.percent}",
    );
    final response = await http.get(url);

    final resobj = quoteFromJson(response.body);

    if (response.statusCode >= 400) {
      setState(() {
        quote = "${response.statusCode} ${resobj.error}";
      });
    } else {
      setState(() {
        quote = resobj.quote ?? "Impossible Error";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Result"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(widget.percent < 80 ? "OH NO!" : "WOW!"),
            Text(
              "You have eaten${widget.percent < 80 ? " only" : ""} "
              "${widget.percent}% of this Food!",
            ),
            Text(quote),
          ],
        ),
      ),
    );
  }
}
