// ignore_for_file: public_member_api_docs, sort_constructors_first
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

  const ViewDetailPage({
    Key? key,
    required this.exams,
    required this.currentQuestionIndex,
    required this.points,
    required this.totalAnswered,
    required this.correctAnswer,
    required this.wrongAnswer,
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
