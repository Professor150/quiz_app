import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/constants/images.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/page/view_all_detail_page.dart';

class ViewDetailPage extends StatefulWidget {
  final List<ExamModel> exams;
  final int currentQuestionIndex;
  final int points;
  final int totalAnswered;
  final int correctAnswer;
  final int wrongAnswer;
  final List<UserPreference> userPreference;
  final List<String> correctAnsweredQuestions;
  final List<String> wrongQuestions;
  final List<String> userTappedOption;
  final List<String> options;
  final Map<String, List<String>> optionsMap;
  final List<String> currentQuestionOptionsIndex;
  const ViewDetailPage({
    Key? key,
    required this.exams,
    required this.currentQuestionIndex,
    required this.points,
    required this.totalAnswered,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.userPreference,
    required this.correctAnsweredQuestions,
    required this.wrongQuestions,
    required this.userTappedOption,
    required this.options,
    required this.optionsMap,
    required this.currentQuestionOptionsIndex,
  }) : super(key: key);

  @override
  _ViewDetailPageState createState() => _ViewDetailPageState();
}

class _ViewDetailPageState extends State<ViewDetailPage> {
  Widget getListTile(String title, String subtitle, Widget image) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: image,
    );
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    int totalQuestion = widget.exams.length;
    int points = widget.points;
    int totalAnswered = widget.totalAnswered;
    int correctAnswer = widget.correctAnswer;
    int wrongAnswer = widget.wrongAnswer;
    

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Details'),
      ),
      body: Column(
        children: [
          getListTile(
            'Total Questions:',
            '$totalQuestion',
            Image.asset(totalQuestionImage),
          ),
          const Divider(
            color: Colors.black,
          ),
          getListTile(
            'Total Answerd:',
            '$totalAnswered',
            Image.asset(
              totalAnsweredImage,
            ),
          ),
          const Divider(
            color: Colors.black,
          ),
          getListTile(
            'Correct Answers:',
            '$correctAnswer',
            Image.asset(correctAnswerImage),
          ),
          const Divider(
            color: Colors.black,
          ),
          getListTile(
            'Incorrect Answers:',
            '$wrongAnswer',
            Image.asset(wrongAnswerImage),
          ),
          const Divider(
            color: Colors.black,
          ),
          getListTile(
            'Total Points:',
            '$points',
            Image.asset(pointsImage),
          ),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(alignment: Alignment.center),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ViewAllDetailPage(
                    point: widget.points,
                    exams: widget.exams,
                    correctAnswer: widget.correctAnswer,
                    wrongAnswer: widget.wrongAnswer,
                    userPreference: widget.userPreference,
                    correctAnsweredQuestions: widget.correctAnsweredQuestions,
                    wrongQuestions: widget.wrongQuestions,
                    userTappedOption: widget.userTappedOption,
                    options: widget.options,
                    optionsMap: widget.optionsMap,
                    currentQuestionOptionsIndex:
                        widget.currentQuestionOptionsIndex,
                  ),
                ),
              );
            },
            child: const Text('View All Details'),
          ),
        ],
      ),
    );
  }
}
