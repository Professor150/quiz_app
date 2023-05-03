import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../core/utils/constants/colors_constants.dart';
import '../../../../core/utils/constants/text_style.dart';

class QuestionOptionLists extends StatefulWidget {
  final List<dynamic> optionsList;
  final int currentQuestionIndex;
  final List<Color> optionsColor;
  final List<dynamic> data;
  final Function gotoNextQuestion;
  final int points;

  QuestionOptionLists({
    required this.optionsList,
    required this.currentQuestionIndex,
    required this.optionsColor,
    required this.data,
    required this.gotoNextQuestion,
    required this.points,
  });

  @override
  State<QuestionOptionLists> createState() => _OptionListsState();
}

class _OptionListsState extends State<QuestionOptionLists> {
  Timer? timer;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var optionsList = widget.optionsList;
    var currentQuestionIndex = widget.currentQuestionIndex;
    var optionsColor = widget.optionsColor;
    var data = widget.data;
    var gotoNextQuestion = widget.gotoNextQuestion;
    int points = widget.points;
    return ListView.builder(
      shrinkWrap: true,
      itemCount: optionsList.length,
      itemBuilder: (BuildContext context, int index) {
        var answer = data[currentQuestionIndex]["correct_answer"];

        return GestureDetector(
          onTap: () {
            setState(() {
              if (answer.toString() == optionsList[index].toString()) {
                optionsColor[index] = Colors.lightGreen;
                points = points + 10;
              } else
                optionsColor[index] = Colors.red.shade300;
              points = points - 5;

              if (currentQuestionIndex < data.length - 1) {
                Future.delayed(const Duration(seconds: 1), () {
                  gotoNextQuestion();
                  points = points + 10;
                });
              } else {
                points = points - 5;
                timer!.cancel();
              }
            });
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 20),
            alignment: Alignment.center,
            width: mediaQuery.width - 100,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: optionsColor[index],
              borderRadius: BorderRadius.circular(12),
            ),
            child: headingText(
              color: blue,
              size: mediaQuery.height * 0.025,
              text: optionsList[index].toString(),
            ),
          ),
        );
      },
    );
  }
}
