import 'dart:async';

import 'package:flutter/material.dart';

import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int isIntro = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.lightBlue,
              Colors.white,
            ],
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 600,
              child: PageView(
                physics: const BouncingScrollPhysics(),
                controller: pageController,
                onPageChanged: (value) {
                  isIntro = value;
                  setState(() {});
                },
                children: const [
                  Intro1(),
                  Intro2(),
                  Intro3(),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: index == isIntro
                      ? const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.black,
                        )
                      : const CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.black26,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Intro1 extends StatelessWidget {
  const Intro1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "Welcome to ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
          ),
          const Text(
            "Weather App ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          const SizedBox(
            height: 30,
          ),
          Image.asset(
            "assets/images/sun.png",
          ),
        ],
      ),
    );
  }
}

class Intro2 extends StatelessWidget {
  const Intro2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 50,
          ),
          Image.asset("assets/images/black.webp"),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Rainy weather",
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class Intro3 extends StatefulWidget {
  const Intro3({Key? key}) : super(key: key);

  @override
  State<Intro3> createState() => _Intro3State();
}

class _Intro3State extends State<Intro3> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
              "assets/images/rain_noon_light_forecast_weather_icon_194358.png"),
          const Text(
            "All situations",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          )
        ],
      ),
    );
  }
}
