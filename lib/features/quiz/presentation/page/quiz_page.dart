import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/core/utils/constants/text_style.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/page/view_detail_page.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quizpage_point_correct_incorrect_show.dart';
import 'package:quiz_app/features/quiz/presentation/widgets/quizpage_question_option_list.dart';
import '../../../../core/utils/constants/colors_constants.dart';
import '../provider/quiz_state.dart';
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
  final ValueNotifier<int> _timerValue = ValueNotifier(30);
  final ValueNotifier<int> _timerValue = ValueNotifier(100);
  int currentQuestionIndex = 0;
  int i = 1;
  Timer? timer;
  int points = 0;
  bool isLoaded = false;
  String currentQuestion = "";
  List<String> options = [];
  bool isFirstQuestion = true;
  bool isLoading = true;
  bool isOptionSelected = false;
  bool isAnswerCorrect = false;
  bool showAnswerStatus = false;
  int totalAnswered = 0;
  int userCorrectAnswer = 0;
  int wrongAnswer = 0;
  Map<int, List> questionOptions = {};
  List<String> correctAnsweredQuestions = [];
  List<String> wrongAnswerdQuestions = [];
  final List<String> userTappedOption = [];
  List<UserPreference> userPreference = [];
  final List<String> currentQuestionOptionsIndex = [];
  Map<int, dynamic> questAndOption = {};

  @override
  void initState() {
    super.initState();
    _fetchQuizData();
    initializeQuiz();
    startTimer();
    questAndOption[i] = {};
  }

  // Future<void> initializeQuiz() async {
  //   if (context.read<FetchAllQuizProvider>().exams.isNotEmpty) {
  //     await context.read<FetchAllQuizProvider>().getQuiz();
  //   }
  // }
  Future<void> initializeQuiz() async {
    final quizProvider = context.read<FetchAllQuizProvider>();

    if (quizProvider.exams.isEmpty) {
      try {
        await quizProvider.getQuiz();
        setState(() {
          currentQuestionIndex = 0;
          optionsMap = Map.fromEntries(quizProvider.exams.asMap().entries.map(
                (entry) => MapEntry(
                    entry.key as String, List.from(entry.value.options)),
              ));
        });
      } catch (error) {}
    }
  }

  Future<void> _fetchQuizData() async {
    await Provider.of<FetchAllQuizProvider>(context, listen: false).getQuiz();

    setState(() {
      isLoading = false;
    });
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
        _timerValue.value = 30;
        startTimer();
        ;
      });
    } else {
      timer?.cancel();
    }
  }

  addOptionToMap(i, opt, int length) {
    questionOptions[i] = List.from(opt);
  }

  void updateListOnTap(List<String> opt) {
    questAndOption[i] = opt;
    print("The option in method is $opt");
    // questAndOption.forEach((i, value) {
    //   questAndOption[i] = opt;
    // });
    print(questAndOption);
    i++;
    print("i++ is $i");
  }

  // void enterToList(List<String> opt) {
  //   optList = opt;
  //   enterToList(optList);
  //   optList.clear();
  // }

  bool isAnswerCorrect = false;
  bool showAnswerStatus = false;
  int totalAnswered = 0;
  int userCorrectAnswer = 0;
  int wrongAnswer = 0;
  Map<String, List<String>> optionsMap = {};

  List<String> correctAnsweredQuestions = [];
  List<String> wrongAnswerdQuestions = [];
  final List<String> userTappedOption = [];

  Map<int, dynamic> questionOption = {};

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: QuizBackGroundColor(
          child: Consumer<FetchAllQuizProvider>(
            builder: (context, quizProvider, _) {
              if (isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (quizProvider.apiResponseStatus == null) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (quizProvider.errorMessage != null) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(quizProvider.errorMessage!),
                      InkWell(
                        onTap: () => Navigator.pushReplacementNamed(
                            context, Routes().splashScreen),
                        child: Center(
                          child: Container(
                            height: mediaQuery.height * 0.06,
                            width: mediaQuery.width * 0.5,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(15), // 15
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepPurple.shade200,
                                  Colors.blue,
                                ],
                              ),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(25)),
                            ),
                            child: const Text(
                              'Restart',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 1.3,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else if (quizProvider.exams.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (currentQuestion !=
                    quizProvider.exams[currentQuestionIndex].question) {
                  print('data');
                  currentQuestion =
                      quizProvider.exams[currentQuestionIndex].question;
                  print('$currentQuestion');
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
                      // point and show if answer correct or incorrect
                      QuizpagePointShowCorectIncorect(
                          mediaQuery: mediaQuery,
                          points: points,
                          showAnswerStatus: showAnswerStatus,
                          isAnswerCorrect: isAnswerCorrect),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: mediaQuery.height * 0.1,
                            width: mediaQuery.width * 0.1,
                            decoration: const BoxDecoration(
                              color: Colors.amber,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '$points',
                              style: const TextStyle(
                                fontSize: 22,
                                letterSpacing: 1.3,
                              ),
                            ),
                          ),
                          SizedBox(width: mediaQuery.width * 0.01),
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

                      SizedBox(
                        height: mediaQuery.height * 0.07,
                      ),

                      Container(
                        alignment: Alignment.center,
                        height: mediaQuery.height * 0.14,
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.blue,
                              offset: const Offset(-1, 2),
                            ),
                          ],
                          color: const Color.fromRGBO(211, 238, 240, 0.898),
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

                      SizedBox(
                        height: mediaQuery.height * 0.35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: options.length,
                          itemBuilder: (BuildContext context, int index) {
                            final answer = quizProvider
                            var answer = quizProvider
                                .exams[currentQuestionIndex].correctAnswer;
                            DateTime? _lastTap;
                            return GestureDetector(
                              onTap: () {
                                if (!showAnswerStatus) {
                                  setState(() {
                                    totalAnswered++;
                                    if (answer == options[index]) {
                                      isAnswerCorrect = true;
                                      optionsColor[index] = Colors.lightGreen;
                                      points = points + 15;
                                      userCorrectAnswer++;
                                      correctAnsweredQuestions
                                          .add(answer[index]);
                                      userTappedOption.add(options[index]);

                                      addOptionToMap(currentQuestionIndex,
                                          options, options.length);
                                      print(
                                          'userTapperCorrectAnswer is $userTappedOption');
                                    } else {
                                      addOptionToMap(currentQuestionIndex,
                                          options, options.length);
                                      print(
                                          'userTapperWrongAnser is $userTappedOption');
                                      wrongAnswer++;
                                      isAnswerCorrect = false;
                                      optionsColor[index] = Colors.red.shade300;

                                      optionsColor[options.indexOf(answer)] =
                                          Colors.lightGreen;
                                      wrongAnswerdQuestions.add(options[index]);
                                      userTappedOption.add(options[index]);
                                    }
                                    // allOptions.add(options[currentQuestionIndex]);

                                    points = points - 5;
                                    showAnswerStatus = true;
                                    Future.delayed(Duration(milliseconds: 500),
                                        () {
                                      setState(() {
                                        showAnswerStatus = false;
                                      });
                                    });

                                    if (currentQuestionIndex <
                                        quizProvider.exams.length - 1) {
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        gotoNextQuestion();
                                      });
                                    } else {
                                      if (currentQuestionIndex ==
                                          quizProvider.exams.length - 1) {
                                        timer!.cancel;
                                        resetColors();
                                        // Dialog Box
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text('Game Over'),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                      bottom: 16),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SizedBox(
                                if (currentQuestionIndex ==
                                    quizProvider.exams.length - 1) {
                                  _lastTap = null;
                                  Navigator.pushReplacementNamed(
                                      context, Routes().category);
                                }
                                setState(() {
                                  updateListOnTap(options);
                                  print("The option is $options");
                                  totalAnswered++;
                                  if (answer == options[index]) {
                                    isAnswerCorrect = true;
                                    optionsColor[index] = Colors.lightGreen;
                                    points = points + 15;
                                    userCorrectAnswer++;
                                    correctAnsweredQuestions.add(answer[index]);
                                    userTappedOption.add(options[index]);
                                    currentQuestionOptionsIndex.add(widget
                                        .exams[currentQuestionIndex].options
                                        .toString());
                                    print(
                                        'Current questions $currentQuestionOptionsIndex');
                                    print(
                                        'userTappedOption correctAnswer $userTappedOption');
                                  } else {
                                    print(
                                        'currentQuestionOptionsIndex is $currentQuestionOptionsIndex');
                                    currentQuestionOptionsIndex.add(widget
                                        .exams[currentQuestionIndex].options
                                        .toString());
                                    wrongAnswer++;
                                    isAnswerCorrect = false;
                                    optionsColor[index] = Colors.red.shade300;

                                    optionsColor[options.indexOf(answer)] =
                                        Colors.lightGreen;
                                    wrongAnswerdQuestions.add(options[index]);
                                    userTappedOption.add(options[index]);
                                    print(
                                        'userTappedOption Wrognquestions $userTappedOption');
                                  }

                                  userPreference.add(UserPreference(
                                      question: quizProvider
                                          .exams[currentQuestionIndex].question,
                                      // option: options,
                                      option: quizProvider
                                          .exams[currentQuestionIndex]
                                          .incorrectAnswers,
                                      userAnswer: answer,
                                      actualAnswer: quizProvider
                                          .exams[currentQuestionIndex]
                                          .correctAnswer));
                                  points = points - 5;
                                  showAnswerStatus = true;
                                  Future.delayed(Duration(milliseconds: 500),
                                      () {
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
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.02,
                                                  ),
                                                  const Text(
                                                      'All questions have been answered.'),
                                                  SizedBox(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.02),
                                                  Text('Total Points: $points',
                                                      style: points >= 0
                                                          ? const TextStyle(
                                                              fontSize: 20,
                                                              color: Colors
                                                                  .lightGreen)
                                                          : const TextStyle(
                                                              fontSize: 20,
                                                              color:
                                                                  Colors.red)),
                                                ],
                                              ),
                                              actions: [
                                                // acticon widget for botton
                                                restartButton(
                                                    context, quizProvider),
                                                // view Detail Button
                                                TextButton(
                                                  child: const Text(
                                                    'View Detail',
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Future.delayed(
                                                        // ignore: prefer_const_constructors
                                                        Duration(
                                                            microseconds: 300),
                                                        () {
                                                      Navigator.of(context)
                                                          .pushReplacement(
                                                        MaterialPageRoute(
                                                          builder: (_) =>
                                                              ViewDetailPage(
                                                            exams: quizProvider
                                                                .exams,
                                                            currentQuestionIndex:
                                                                currentQuestionIndex,
                                                            points: points,
                                                            correctAnswer:
                                                                userCorrectAnswer,
                                                            totalAnswered:
                                                                totalAnswered,
                                                            wrongAnswer:
                                                                wrongAnswer,
                                                            correctAnsweredQuestions:
                                                                correctAnsweredQuestions,
                                                            wrongQuestions:
                                                                wrongAnswerdQuestions,
                                                            userTappedOption:
                                                                userTappedOption,
                                                            options: options,
                                                            questionOptions:
                                                                questionOptions,
                                                            alloptions: [],
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
                                }
                              },
                              // questions option Lists
                              child: QuestionOptionsList(
                                  mediaQuery: mediaQuery,
                                  options: options,
                                  index: index),
                                                            0.02),
                                                Text('Total Points: $points',
                                                    style: points >= 0
                                                        ? const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors
                                                                .lightGreen)
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
                                                      const Duration(
                                                          microseconds: 300),
                                                      () {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                QuizScreen(
                                                                  exams:
                                                                      quizProvider
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
                                                      const Duration(
                                                          microseconds: 300),
                                                      () {
                                                    print(
                                                        ' this is ootion maps $optionsMap');

                                                    Navigator.of(context)
                                                        .pushReplacement(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            ViewDetailPage(
                                                          currentQuestionIndex:
                                                              currentQuestionIndex,
                                                          exams: quizProvider
                                                              .exams,
                                                          points: points,
                                                          correctAnswer:
                                                              userCorrectAnswer,
                                                          totalAnswered:
                                                              totalAnswered,
                                                          wrongAnswer:
                                                              wrongAnswer,
                                                          userPreference:
                                                              userPreference,
                                                          correctAnsweredQuestions:
                                                              correctAnsweredQuestions,
                                                          wrongQuestions:
                                                              wrongAnswerdQuestions,
                                                          userTappedOption:
                                                              userTappedOption,
                                                          options: options,
                                                          optionsMap:
                                                              optionsMap,
                                                          currentQuestionOptionsIndex:
                                                              currentQuestionOptionsIndex,
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
                      ),
                      SizedBox(
                        height: mediaQuery.height * 0.061,
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

  TextButton restartButton(
      BuildContext context, FetchAllQuizProvider quizProvider) {
    final quizState = Provider.of<QuizState>(context);
    return TextButton(
      child: const Text(
        'Restart',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: () {
        Future.delayed(const Duration(microseconds: 300), () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => QuizScreen(
                        exams: quizProvider.exams,
                        category:
                            quizProvider.exams[currentQuestionIndex].category,
                      )));
        });

        quizState.resetState();
      },
    );
  }
}
