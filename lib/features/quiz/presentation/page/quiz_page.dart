import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/page/view_detail_page.dart';
import '../../../../core/utils/constants/colors_constants.dart';
import '../../../../core/utils/constants/text_style.dart';
import '../widgets/quiz_header.dart';
import '../widgets/quizapp_bg_gradinant.dart';

class QuizScreen extends StatefulWidget {
  final List<ExamModel> exams;
  final String category;
  const QuizScreen({
    super.key,
    required this.exams,
    required this.category,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final ValueNotifier<int> _timerValue = ValueNotifier(15);
  int currentQuestionIndex = 0;
  Timer? timer;
  int points = 0;
  bool isLoaded = false;
  String currentQuestion = "";
  List<String> options = [];
  bool isFirstQuestion = true;

  @override
  void initState() {
    super.initState();
    if (context.read<FetchAllQuizProvider>().exams.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<FetchAllQuizProvider>().getQuiz();
      });
    }
    startTimer();
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }

  startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerValue.value > 0) {
        _timerValue.value = _timerValue.value - 1;
      } else {
        gotoNextQuestion();
      }
    });
  }

  gotoNextQuestion() {
    if (currentQuestionIndex <
        context.read<FetchAllQuizProvider>().exams.length - 1) {
      setState(() {
        isLoaded = false;
        currentQuestionIndex++;
        resetColors();
        timer!.cancel();
        _timerValue.value = 100;
        startTimer();
      });
    } else {
      timer?.cancel();
    }
  }

  void handleNextButtonTap() {
    if (currentQuestionIndex <
        context.read<FetchAllQuizProvider>().exams.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      const AlertDialog(
        actions: [
          Text('Question Is Finished'),
        ],
      );
      Future.delayed(const Duration(milliseconds: 300), () {
        Navigator.pushReplacementNamed(context, Routes().category);
      });
    }
  }

  bool isAnswerCorrect = false;
  bool showAnswerStatus = false;
  int totalAnswered = 0;
  int userCorrectAnswer = 0;
  int wrongAnswer = 0;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: QuizBgColor(
          child: Consumer<FetchAllQuizProvider>(
            builder: (context, quizProvider, _) {
              if (quizProvider.apiResponseStatus == null) {
                return const Center(
                    child: CircularProgressIndicator.adaptive());
              } else if (quizProvider.errorMessage != null) {
                return Center(
                  child: Text(quizProvider.errorMessage!),
                );
              } else {
                if (currentQuestion !=
                    quizProvider.exams[currentQuestionIndex].question) {
                  print('data ');
                  currentQuestion =
                      quizProvider.exams[currentQuestionIndex].question;
                  options.clear();
                  options.addAll(
                      quizProvider.exams[currentQuestionIndex].options
                        ..shuffle());
                }

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      // header  leadin and traling icon and timer
                      ValueListenableBuilder<int>(
                          valueListenable: _timerValue,
                          builder: (context, time, _) {
                            return QuizHeader(
                                time,
                                quizProvider
                                    .exams[currentQuestionIndex].difficulty,
                                currentQuestionIndex,
                                quizProvider.exams,
                                options,
                                points);
                          }),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: mediaQuery.height * 0.1,
                            width: mediaQuery.width * 0.1,
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$points',
                              style: TextStyle(
                                fontSize: 22,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          if (showAnswerStatus)
                            AnimatedOpacity(
                              duration: Duration(milliseconds: 500),
                              opacity: showAnswerStatus ? 1.0 : 0.0,
                              child: Text(
                                isAnswerCorrect ? 'Correct!' : 'Incorrect!',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: isAnswerCorrect
                                      ? Colors.lightGreen
                                      : Colors.red,
                                ),
                              ),
                            ),
                        ],
                      ),
                      Text(
                        'Total Answered: $totalAnswered',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Correct Answers: $userCorrectAnswer',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Wrong Answers: $wrongAnswer',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      SizedBox(
                        height: mediaQuery.height * 0.07,
                      ),

                      // queation text
                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery.height * 0.14,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue,
                              offset: Offset(-1, 2),
                            ),
                          ],
                          color: Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: normalText(
                          color: Colors.black,
                          size: 20,
                          text:
                              quizProvider.exams[currentQuestionIndex].question,
                        ),
                      ),

                      SizedBox(height: mediaQuery.height * 0.05),

                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: options.length,
                        itemBuilder: (BuildContext context, int index) {
                          var answer = quizProvider
                              .exams[currentQuestionIndex].correctAnswer;
                          DateTime? _lastTap;
                          return GestureDetector(
                            onTap: () {
                              if (currentQuestionIndex ==
                                  quizProvider.exams.length - 1) {
                                _lastTap = null;
                                Navigator.pushReplacementNamed(
                                    context, Routes().category);
                              }
                              setState(() {
                                totalAnswered++;
                                if (answer == options[index]) {
                                  isAnswerCorrect = true;
                                  optionsColor[index] = Colors.lightGreen;
                                  points = points + 15;
                                  userCorrectAnswer++;
                                } else {
                                  wrongAnswer++;
                                  isAnswerCorrect = false;
                                  optionsColor[index] = Colors.red.shade300;

                                  optionsColor[options.indexOf(answer)] =
                                      Colors.lightGreen;
                                }
                                points = points - 5;
                                showAnswerStatus = true;
                                Future.delayed(Duration(milliseconds: 500), () {
                                  setState(() {
                                    showAnswerStatus = false;
                                  });
                                });
                                if (currentQuestionIndex <
                                    quizProvider.exams.length - 1) {
                                  Future.delayed(
                                      const Duration(milliseconds: 500), () {
                                    gotoNextQuestion();
                                  });
                                } else {
                                  if (currentQuestionIndex ==
                                      quizProvider.exams.length - 1) {
                                    timer!.cancel;
                                    resetColors();
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text('Game Over'),
                                          contentPadding:
                                              EdgeInsets.only(bottom: 16),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.02,
                                              ),
                                              const Text(
                                                  'All questions have been answered.'),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.02),
                                              Text('Total Points: $points',
                                                  style: points >= 0
                                                      ? const TextStyle(
                                                          fontSize: 20,
                                                          color:
                                                              Colors.lightGreen)
                                                      : const TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                              child: const Text(
                                                'Restart',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                Future.delayed(
                                                    Duration(microseconds: 300),
                                                    () {
                                                  Navigator.pushReplacement(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (_) => QuizScreen(
                                                                    exams: quizProvider
                                                                        .exams,
                                                                    category: quizProvider
                                                                        .exams[
                                                                            currentQuestionIndex]
                                                                        .category,
                                                                  )));
                                                });

                                                setState(() {
                                                  points = 0;
                                                  currentQuestionIndex = 0;
                                                });
                                              },
                                            ),
                                            TextButton(
                                              child: const Text(
                                                'View Detail',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              onPressed: () {
                                                Future.delayed(
                                                    Duration(microseconds: 300),
                                                    () {
                                                  Navigator.of(context)
                                                      .pushReplacement(
                                                    MaterialPageRoute(
                                                      builder: (_) =>
                                                          ViewDetailPage(
                                                        currentQuestionIndex:
                                                            currentQuestionIndex,
                                                        exams:
                                                            quizProvider.exams,
                                                        points: points,
                                                        correctAnswer:
                                                            userCorrectAnswer,
                                                        totalAnswered:
                                                            totalAnswered,
                                                        wrongAnswer:
                                                            wrongAnswer,
                                                      ),
                                                    ),
                                                  );
                                                });
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  }
                                  timer!.cancel();
                                }
                              });
                            },
                            // questions option Lists
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              alignment: Alignment.center,
                              width: mediaQuery.width - 100,
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: optionsColor[index],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                overflow: TextOverflow.ellipsis,
                                options[index],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.061,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          fixedSize: Size(
                              mediaQuery.width * 0.55, mediaQuery.width * 0.13),
                        ),
                        onPressed: handleNextButtonTap,
                        child: const Text(
                          'Next',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
