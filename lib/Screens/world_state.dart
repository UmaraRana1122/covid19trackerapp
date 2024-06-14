import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 5), vsync: this)
        ..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.dispose();
  }

  final colorList = [Colors.red, Colors.blue, Colors.green];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xff272726),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              PieChart(
                chartRadius: MediaQuery.of(context).size.width / 3.2,
                legendOptions:
                    LegendOptions(legendPosition: LegendPosition.left),
                dataMap: {
                  "total": 20,
                  "Recovered": 15,
                  "Deaths": 5,
                },
                animationDuration: Duration(milliseconds: 1200),
                chartType: ChartType.ring,
                colorList: colorList,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ResusableRow(title: "Total", value: "200"),
                      ResusableRow(title: "Total", value: "200"),
                      ResusableRow(title: "Total", value: "200")
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.green),
                child: Center(
                    child: Text(
                  "Track Countries",
                  style: TextStyle(
                      fontWeight: FontWeight.w700, color: Colors.white),
                )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ResusableRow extends StatelessWidget {
  String title, value;
  ResusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(title), Text(value)]),
      ),
    );
  }
}
