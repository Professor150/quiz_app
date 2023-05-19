import 'package:flutter/material.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/viewalldetail_custom_nav_button_widget.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/viewalldetail_question_widget.dart';

class ViewAllDetailPage extends StatefulWidget {
  final List<ExamModel> exams;
  final int point;
  final int correctAnswer;
  final int wrongAnswer;
  final List<String> correctAnsweredQuestions;
  final List<String> wrongQuestions;
  final List<String> userTappedOption;
  final List<String> options;
  final Map<int, List> questionOptions;

  const ViewAllDetailPage({
    Key? key,
    required this.exams,
    required this.point,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.correctAnsweredQuestions,
    required this.wrongQuestions,
    required this.userTappedOption,
    required this.options,
    required this.questionOptions,
  }) : super(key: key);

  @override
  State<ViewAllDetailPage> createState() => _ViewAllDetailPageState();
}

class _ViewAllDetailPageState extends State<ViewAllDetailPage> {
  int questionIndex = 0;

  void goToNextQuestion() {
    setState(() {
      if (questionIndex < widget.exams.length - 1) {
        questionIndex++;
      } else {}
    });
  }

  void backToQuestion() {
    setState(() {
      if (questionIndex < widget.exams.length) {
        questionIndex--;
      } else {
        return;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final userPressedOption = widget.userTappedOption[questionIndex];
    final List<String> allQuestions = []
      ..addAll(widget.wrongQuestions)
      ..addAll(widget.correctAnsweredQuestions);
    final mediaQuery = MediaQuery.of(context).size;
    final exam = widget.exams[questionIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: Text(
          'Total Points :  ${widget.point}',
          style: const TextStyle(
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              ' Attempted Questions: ${allQuestions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          QuestionWidget(
            mediaQuery: mediaQuery,
            exam: exam,
            questionIndex: questionIndex,
            userPressedOption: userPressedOption,
            questionOptions: widget.questionOptions,
          ),
          const SizedBox(
            height: 10,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (questionIndex > 0 && questionIndex <= widget.exams.length - 1)
                NavButtonWidget(
                  mediaQuery: mediaQuery,
                  navQuestion: backToQuestion,
                  title: "Previous",
                ),
              if (questionIndex < allQuestions.length - 1)
                NavButtonWidget(
                  mediaQuery: mediaQuery,
                  navQuestion: goToNextQuestion,
                  title: "Next",
                ),
              if (questionIndex == widget.exams.length - 1)
                NavButtonWidget(
                  mediaQuery: mediaQuery,
                  navQuestion: () =>
                      Navigator.popAndPushNamed(context, Routes().category),
                  title: "Finish",
                ),
            ],
          ),
        ],
      ),
    );
  }
}
