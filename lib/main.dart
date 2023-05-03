import 'package:flutter/material.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/presentation/page/splash_page.dart';

import 'features/quiz/presentation/page/quiz_page.dart';

main() {
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "quick",
      ),
      initialRoute: Routes().homepage,
      routes: {
        Routes().homepage: (context) => QuizScreen(),
        // Routes().splashScreen: (context) => SplashScreen(),
      },
    );
  }
}
