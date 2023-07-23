import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/utils/constants/images.dart';
import 'package:quiz_app/features/quiz/presentation/page/view_all_detail_page.dart';
import 'package:quiz_app/features/quiz/presentation/provider/view_detail_provider.dart';

class ViewDetailScreen extends StatefulWidget {
  @override
  _ViewDetailPageState createState() => _ViewDetailPageState();
}

class _ViewDetailPageState extends State<ViewDetailScreen> {
  Widget getListTile(String title, String subtitle, Widget image) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: image,
    );
  }

  @override
  Widget build(BuildContext context) {
    ViewDetailProvider viewDetailProvider =
        Provider.of<ViewDetailProvider>(context);

    int totalQuestion = viewDetailProvider.exams.length;
    int points = viewDetailProvider.points;
    int totalAnswered = viewDetailProvider.totalAnswered;
    int correctAnswer = viewDetailProvider.correctAnswer;
    int wrongAnswer = viewDetailProvider.wrongAnswer;

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
            'Total Answered:',
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
                  builder: (_) => Consumer<ViewDetailProvider>(
                    builder: (context, value, child) => ViewAllDetailPage(
                      correctAnswer: viewDetailProvider.correctAnswer,
                      correctAnsweredQuestions:
                          viewDetailProvider.correctAnsweredQuestions,
                      exams: viewDetailProvider.exams,
                      options: viewDetailProvider.options,
                      point: viewDetailProvider.points,
                      questionOptions: viewDetailProvider.questionOptions,
                      userTappedOption: viewDetailProvider.userTappedOption,
                      wrongAnswer: viewDetailProvider.wrongAnswer,
                      wrongQuestions: viewDetailProvider.wrongQuestions,
                    ),
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
