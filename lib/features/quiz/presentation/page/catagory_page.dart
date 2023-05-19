import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/category_widget_datapage.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/category_widget_didchange_dependency.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quizapp_bg_gradinant.dart';

class CategoryScreen extends StatefulWidget {
  final List<ExamModel> exams;
  const CategoryScreen({
    Key? key,
    required this.exams,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final dataFetcher = QuizDataFetcher(context);
    dataFetcher.fetchQuizData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('Topic'),
        centerTitle: true,
        leading: const Text(''),
      ),
      backgroundColor: Colors.deepPurple.shade100,
      body: QuizBackGroundColor(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CategoryDataPage(),
            ],
          ),
        ),
      )
    );
  }
}
