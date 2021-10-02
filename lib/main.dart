import 'package:camera/camera.dart';
import "package:flutter/material.dart";
import "package:food_busters/views/login.dart";
import "package:food_busters/views/scanfood.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Food Busters Demo",
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Home", style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {},
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: const [
                Text("\"GREETINGS, ", style: TextStyle(fontSize: 18)),
                Text("USER01\"", style: TextStyle(fontSize: 24)),
              ],
            ),
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    "https://i.pinimg.com/originals/a9/f8/9e/a9f89e792c741ce4d5b6be989fcb16ba.png",
                  ),
                ),
              ),
            ),
            bigBtn(
              onPressed: () async {
                final cameras = await availableCameras();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanPage(cameras: cameras),
                  ),
                );
              },
              content: "SCAN!",
              padding: 20,
            ),
            bigBtn(onPressed: () {}, content: "MY POINTS", padding: 15),
            bigBtn(onPressed: () {}, content: "MY RECORD", padding: 15),
          ],
        ),
      ),
    );
  }

  Widget bigBtn({
    required void Function() onPressed,
    required String content,
    required double padding,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(content, style: btnTextStyle),
        style: ElevatedButton.styleFrom(padding: EdgeInsets.all(padding)),
      ),
    );
  }
}

const btnTextStyle = TextStyle(fontSize: 26);
