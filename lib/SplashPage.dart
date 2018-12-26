import 'package:flutter/material.dart';
import 'package:flutter_gank/HomePage.dart';
import 'package:flutter_gank/view/GradientButton.dart';
import 'package:nima/nima_actor.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double screenWidth;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        NimaActor(
          "assets/robot.nima",
          alignment: Alignment.center,
          fit: BoxFit.cover,
          animation: "Flight",
        ),
        Container(color: Colors.black54),
        Positioned(
          bottom: 200,
          child: Text(
            "Flutter News",
            style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.none),
          ),
        ),
        Positioned(
          bottom: 120,
          width: screenWidth - 50,
          child: Text(
            "Powerful Realtime Technology News for Apps \n Build By Espoir.",
            style: TextStyle(
                color: Colors.white54,
                fontSize: 18,
                decoration: TextDecoration.none),
            textAlign: TextAlign.center,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8, 32),
                child: GradientButton(
                  colors: [Colors.orange, Colors.red],
                  height: 40,
                  radius: 50,
                  child: Text("  Have a fun  "),
                  onTap: () {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 0, 32),
                child: GradientButton(
                  colors: [Colors.lightGreen, Colors.green[700]],
                  height: 40,
                  radius: 50,
                  child: Text("  Start exploring  "),
                  onTap: () {
                    Navigator.push(context,
                        new MaterialPageRoute(builder: (context) {
                      return new HomePage();
                    }));
                  },
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
