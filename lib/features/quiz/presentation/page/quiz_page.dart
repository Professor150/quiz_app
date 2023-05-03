import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors_constants.dart';
import '../../../../core/utils/constants/images.dart';
import '../../../../core/utils/constants/text_style.dart';
import '../../data/data source/remote/api_service.dart';
import '../../data/model/quiz_data_model.dart';
import '../widgets/question_option.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quiz_question_point.dart';
import '../widgets/quizapp_bg_gradinant.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  // ExamsModel? examsModel;

  final TextEditingController _controller = TextEditingController();
  var currentQuestionIndex = 0;
  int seconds = 30;
  Timer? timer;
  Future<ExamsModel>? quiz;

  int point = 0;

  var isLoaded = false;

  var optionsList = [];

  @override
  void initState() {
    super.initState();
    quiz = getQuiz();
    startTimer();
  }

  @override
  void dispose() {
    timer!.cancel();
    super.dispose();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (seconds > 0) {
          seconds--;
        } else {
          gotoNextQuestion();
        }
      });
    });
  }

  gotoNextQuestion() {
    isLoaded = false;
    currentQuestionIndex++;
    resetColors();
    timer!.cancel();
    seconds = 30;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: QuizBgColor(
        FutureBuilder(
          future: quiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              if (isLoaded == false) {
                optionsList = data[currentQuestionIndex]["incorrect_answers"];
                optionsList.add(data[currentQuestionIndex]["correct_answer"]);
                optionsList.shuffle();
                isLoaded = true;
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    // header  leadin and traling icon and timer
                    QuizHeader(seconds),
                    const SizedBox(
                      height: 12,
                    ),
                    Image.asset(ideas, width: mediaQuery.width * 0.5),
                    const SizedBox(
                      height: 12,
                    ),
                    // question indexs and points
                    // QuestionPoints(, currentQuestionIndex, data),
                    QuestionPoints(
                        points: point,
                        currentQuestionIndex: currentQuestionIndex,
                        data: data),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                    // queation text
                    normalText(
                      color: Colors.white,
                      size: 20,
                      text: data[currentQuestionIndex]["question"],
                    ),
                    SizedBox(height: mediaQuery.height * 0.02),
                    // questions index and option list

                    QuestionOptionLists(
                      optionsList: optionsList,
                      currentQuestionIndex: currentQuestionIndex,
                      optionsColor: optionsColor,
                      data: data,
                      gotoNextQuestion: gotoNextQuestion,
                      points: point + 10,
                    )
                    //
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              );
            }
          },
        ),
      )),
    );
  }
}
