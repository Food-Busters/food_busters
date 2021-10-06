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
  @override
  void initState() {
    super.initState();
  }

  Future<String> getQuote() async {
    // * SIMULATE SERVER PROCESSING
    await Future.delayed(const Duration(seconds: 2));

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=${widget.percent}&lang=en",
    );
    final response = await http.get(url);

    if (response.statusCode >= 400) {
      return "${response.statusCode} ${response.body}";
    } else {
      final resobj = quoteFromJson(response.body);
      return resobj.quote;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan Result"),
      ),
      body: Center(
        child: FutureBuilder<String>(
          future: getQuote(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final isBad = widget.percent < 80;
              final quote = snapshot.data ?? "Impossible Error";
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isBad ? "Oh no!" : "Wow!",
                    style: const TextStyle(fontSize: 28),
                  ),
                  Text(
                    quote,
                    style: const TextStyle(fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () {},
      ),
    );
  }
}
