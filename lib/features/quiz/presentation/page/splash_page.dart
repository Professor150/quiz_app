import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/core/utils/constants/images.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quizapp_bg_gradinant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, Routes().category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;

    return Scaffold(
      
      body: QuizBackGroundColorForViewDetailPage(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mediaQuery.height * 0.06),
                Text("Let's Play Quiz,",
                    style: Theme.of(context).textTheme.headline4),
                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                const Text(
                  "Test your skills",
                  style: TextStyle(
                      fontSize: 20,
                      letterSpacing: 1.3,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: mediaQuery.height * 0.1,
                ),
                Image(
                  image: AssetImage(splashScreenImage),
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: mediaQuery.height * 0.1,
                ),
                const SpinKitCircle(
                  size: 60,
                  color: Colors.blue,
                ),
                const Spacer(),

                SizedBox(
                  height: mediaQuery.height * 0.01,
                ),
                // it will take 2/6 spaces
              ],
            ),
          ),
        ),
      ),
    );
  }
}
