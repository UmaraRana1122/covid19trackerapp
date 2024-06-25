import 'package:covid19trackerapp/Screens/world_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DetailsScreen extends StatefulWidget {
  String name;
  String image;
  int todayCases, todayDeaths, active, todayRecovered, critical, test;
  DetailsScreen(
      {required this.name,
      required this.active,
      required this.critical,
      required this.image,
      required this.test,
      required this.todayCases,
      required this.todayDeaths,
      required this.todayRecovered});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                      ),
                      ResusableRow(
                          title: 'Cases', value: widget.todayCases.toString()),
                      ResusableRow(
                          title: 'Recovered',
                          value: widget.todayRecovered.toString()),
                      ResusableRow(
                          title: 'Active', value: widget.active.toString()),
                      ResusableRow(
                          title: 'Death', value: widget.todayDeaths.toString()),
                      ResusableRow(
                          title: 'Test', value: widget.test.toString()),
                      ResusableRow(
                          title: 'Total Recovered',
                          value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
