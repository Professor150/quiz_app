import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
import 'package:quiz_app/features/quiz/presentation/page/quiz_page.dart';
import 'package:quiz_app/features/quiz/presentation/page/splash_page.dart';
import 'package:quiz_app/features/quiz/presentation/provider/quiz_state.dart';
import 'features/quiz/presentation/page/catagory_page.dart';

main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FetchAllQuizProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => QuizState(),
        ),
      
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepPurple),
        initialRoute: Routes().splashScreen,
        routes: {
          Routes().category: (context) => const CategoryScreen(
                exams: [],
              ),
          Routes().quizScreen: (context) => const QuizScreen(
                exams: [],
                category: '',
              ),
          Routes().splashScreen: (context) => const WelcomeScreen(),
        },
      ),
    );
  }
}
