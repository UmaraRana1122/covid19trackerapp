import 'package:covid19trackerapp/Model/worl_state_model.dart';
import 'package:covid19trackerapp/Services/state_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({super.key});

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 10), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  final colorList = [Colors.blue, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
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
              FutureBuilder<WorldStateModel>(
                future: stateServices.fetchWorldStateRecords(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Expanded(
                      child: Center(
                        child: SpinKitFadingCircle(
                          color: Colors.blue,
                          size: 50,
                          controller: controller,
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Center(
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    return Expanded(
                      child: Column(
                        children: [
                          PieChart(
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: LegendOptions(
                                legendPosition: LegendPosition.left),
                            dataMap: {
                              "Total": double.parse(
                                snapshot.data!.cases.toString(),
                              ),
                              "Recovered": double.parse(
                                snapshot.data!.recovered.toString(),
                              ),
                              "Deaths": double.parse(
                                snapshot.data!.deaths.toString(),
                              ),
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
                                  ResusableRow(
                                      title: "Total Cases",
                                      value: snapshot.data!.cases.toString()),
                                  ResusableRow(
                                      title: "Recovered",
                                      value:
                                          snapshot.data!.recovered.toString()),
                                  ResusableRow(
                                      title: "Deaths",
                                      value: snapshot.data!.deaths.toString()),
                                  ResusableRow(
                                      title: "Active",
                                      value: snapshot.data!.active.toString()),
                                  ResusableRow(
                                      title: "Critical",
                                      value:
                                          snapshot.data!.critical.toString()),
                                  ResusableRow(
                                      title: "Tests",
                                      value: snapshot.data!.tests.toString()),
                                  ResusableRow(
                                      title: "Deaths Per Day",
                                      value: snapshot.data!.todayDeaths
                                          .toString()),
                                  ResusableRow(
                                      title: "Today Recovered",
                                      value: snapshot.data!.todayRecovered
                                          .toString()),
                                  ResusableRow(
                                      title: "Population",
                                      value:
                                          snapshot.data!.population.toString()),
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
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            )),
                          )
                        ],
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Center(
                        child: Text('No data available'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResusableRow extends StatelessWidget {
  final String title, value;
  const ResusableRow({super.key, required this.title, required this.value});

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
