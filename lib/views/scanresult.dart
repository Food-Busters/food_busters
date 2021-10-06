import "dart:io";
import "package:camera/camera.dart";
import "package:flutter/material.dart";
import "package:food_busters/components/background.dart";
import "package:food_busters/models/quote.dart";
import "package:food_busters/views/pollution_info.dart";
import "package:http/http.dart" as http;

// ! Temporary, as in production we don't random user's result
import "dart:math";

class ScanResultPage extends StatefulWidget {
  const ScanResultPage({Key? key, required this.image}) : super(key: key);

  final XFile image;

  @override
  _ScanResultPageState createState() => _ScanResultPageState();
}

class _ScanResultPageState extends State<ScanResultPage> {
  @override
  void initState() {
    super.initState();
  }

  int percent = 0;

  Future<String> getQuote() async {
    // * SIMULATE IMAGE PROCESSING
    await Future.delayed(const Duration(milliseconds: 500));
    percent = Random().nextInt(100) + 1;

    final url = Uri.parse(
      "https://food-waste-quotes.vercel.app/api/quote?percent=${percent}&lang=en",
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
      backgroundColor: const Color(0xFFF1E5D9),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Scan Result"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          bgImage("assets/images/clouds/top_orange.png"),
          Center(
            child: FutureBuilder<String>(
              future: getQuote(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  final isBad = percent < 80;
                  final quote = snapshot.data ?? "Impossible Error";
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 24.0),
                        child: SizedBox(
                          child: Image.file(File(widget.image.path)),
                          height: 300,
                        ),
                      ),
                      Text(
                        "You have eaten${percent < 40 ? " only" : ""} "
                        "$percent% of the dish...",
                      ),
                      Text(
                        isBad ? "Oh no!" : "Wow!",
                        style: const TextStyle(fontSize: 28),
                      ),
                      Text(
                        quote,
                        style: const TextStyle(fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PollutionInfo(percent: percent),
                              ),
                            );
                          },
                          child: const Text(
                            "Learn more",
                            style: TextStyle(fontSize: 22),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                          ),
                        ),
                      ),
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.share),
        onPressed: () {},
      ),
    );
  }
}
