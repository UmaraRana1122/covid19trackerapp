import 'dart:async';

import 'package:covid19trackerapp/Screens/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController controller =
      AnimationController(duration: Duration(seconds: 5), vsync: this)
        ..repeat();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        const Duration(seconds: 6),
        () => Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) {
              return WorldStateScreen();
            })));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: controller,
            child: Center(
              child: Container(
                height: 200,
                width: 200,
                child: Image(image: AssetImage('assets/images/virus.png')),
              ),
            ),
            builder: (BuildContext context, Widget? child) {
              return Transform.rotate(
                angle: controller.value * 2.0 * math.pi,
                child: child,
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          Text("Covid 19 Tracker App",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20))
        ],
      ),
    );
  }
}
