import "package:flutter/material.dart";
import 'package:food_busters/views/grab/grab_info.dart';

class GrabPage extends StatefulWidget {
  const GrabPage({Key? key}) : super(key: key);

  @override
  _GrabPageState createState() => _GrabPageState();
}

class _GrabPageState extends State<GrabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "DELIVER TO",
              style: TextStyle(
                fontWeight: FontWeight.w100,
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
            Text(
              "123/456 Flutter Village",
              style: TextStyle(
                fontSize: 16,
              ),
            )
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: const [
          Icon(Icons.search),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(Icons.menu),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            child: Image.asset("assets/images/grab/grab_1.png"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GrabInfoPage(),
                ),
              );
            },
          ),
          Image.asset("assets/images/grab/grab_2.jpeg"),
        ],
      ),
    );
  }
}
