import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splashScreen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _moveNextScreen(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, Routes().category);
    });
  }

  @override
  void initState() {
    super.initState();
    _moveNextScreen(context);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.yMMMMEEEEd().format(DateTime.now());
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(30),
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent.shade100, Colors.blue.shade200],
              stops: [0.5, 0.9],
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'Are You Ready For Quiz ',
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              // Image(
              //   height: MediaQuery.of(context).size.height * 0.2,
              //   width: double.infinity,
              //   image: const AssetImage('assets/images/ideas.png'),
              //   fit: BoxFit.contain,
              // ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              const SpinKitWave(
                // duration: Duration(seconds: 4),
                size: 70,
                color: Colors.blue,
              ),
              const Spacer(),
              Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, Routes().category);
                  },
                  child: Text('Skip'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
