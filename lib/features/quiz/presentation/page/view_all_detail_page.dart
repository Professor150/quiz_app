// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

class ViewAllDetailPage extends StatefulWidget {
  final List<ExamModel> exams;
  final int point;
  final int correctAnswer;
  final int wrongAnswer;
  const ViewAllDetailPage({
    Key? key,
    required this.exams,
    required this.point,
    required this.correctAnswer,
    required this.wrongAnswer,
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
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
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
            padding: EdgeInsets.all(8.0),
            child: Text(
              ' Attempted Questions: ${widget.exams.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final exam = widget.exams[questionIndex];

                final isCorrectAnswer =
                    exam.selectedAnswer == exam.correctAnswer;
                final shuffledOptions = List<String>.from(exam.options);
                final suffel = shuffledOptions.shuffle(Random());
                return ListTile(
                  title: Container(
                    padding: EdgeInsets.all(12),
                    margin: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    child: Text(
                      '${questionIndex + 1})   ${exam.question}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: exam.options.length,
                        itemBuilder: (context, index) {
                          final option = exam.options[index];
                          final isCorrectOption = option == exam.correctAnswer;
                          final optionColor =
                              isCorrectOption ? Colors.green : Colors.red;
                          final options = shuffledOptions[index];

                          return Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            height: mediaQuery.height * 0.05,
                            width: mediaQuery.width - 100,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: optionColor,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: optionColor,
                              ),
                            ),
                            child: Text(
                              options,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (questionIndex > 0 && questionIndex <= widget.exams.length - 1)
                ElevatedButton(
                  onPressed: backToQuestion,
                  child: Text('Back'),
                ),
              if (questionIndex < widget.exams.length - 1)
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(double.infinity, mediaQuery.height * 0.04)),
                    onPressed: goToNextQuestion,
                    child: Text('Next')),
            ],
          ),
        ],
      ),
    );
  }
}
