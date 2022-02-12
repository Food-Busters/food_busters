import "package:flutter/material.dart";
import "package:pie_chart/pie_chart.dart";

class GrabInfoPage extends StatefulWidget {
  const GrabInfoPage({Key? key}) : super(key: key);

  @override
  _GrabInfoPageState createState() => _GrabInfoPageState();
}

class _GrabInfoPageState extends State<GrabInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("FBI"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Image.asset(
                        "assets/images/grab/delicious.jpeg",
                        height: 150,
                      ),
                      Positioned(
                        top: -25,
                        right: -25,
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage("assets/images/logo_white.jpg"),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  PieChart(
                    dataMap: const {
                      "Protein": 45,
                      "Fat": 30,
                      "Carbohydrate": 25
                    },
                    chartType: ChartType.ring,
                    chartRadius: 100,
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.bottom,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Image.asset("assets/images/grab/grab_2.jpeg"),
        ],
      ),
    );
  }
}
