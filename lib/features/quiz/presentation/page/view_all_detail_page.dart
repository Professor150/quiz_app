import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

class ViewAllDetailPage extends StatefulWidget {
  final List<ExamModel> exams;
  final int point;
  final int correctAnswer;
  final int wrongAnswer;
  final List<UserPreference> userPreference;
  final List<String> correctAnsweredQuestions;
  final List<String> wrongQuestions;
  final List<String> userTappedOption;
  final List<String> options;
  final List<String> alloptions;
  List<Map<String, dynamic>> questionOptions;

  ViewAllDetailPage({
    Key? key,
    required this.exams,
    required this.point,
    required this.correctAnswer,
    required this.wrongAnswer,
    required this.userPreference,
    required this.correctAnsweredQuestions,
    required this.wrongQuestions,
    required this.userTappedOption,
    required this.options,
    required this.alloptions,
    required this.questionOptions,
  }) : super(key: key);

  @override
  State<ViewAllDetailPage> createState() => _ViewAllDetailPageState();
}

class _ViewAllDetailPageState extends State<ViewAllDetailPage> {
  int questionIndex = 0;
  int i = 1;
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

  Map<int, dynamic> questAndOption = {};
  void updateListOnTap(List<String> opt) {
    questAndOption[i] = opt;
    print("The option in method is $opt");

    print(questAndOption);
    i++;
    print("i++ is $i");
  }

  @override
  Widget build(BuildContext context) {
    final userPressedoption = widget.userTappedOption[questionIndex];
    final List<String> allQuestions = []
      ..addAll(widget.wrongQuestions)
      ..addAll(widget.correctAnsweredQuestions);
    final mediaQuery = MediaQuery.of(context).size;
    final exam = widget.exams[questionIndex];
    final options = widget.options;
    final alloptions = widget.alloptions;
    final questionOption = widget.questionOptions;
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
              ' Attempted Questions: ${allQuestions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: mediaQuery.height * 0.4,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
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
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: exam.options.length,
                        itemBuilder: (context, optionIndex) {
                          final option = exam.options[optionIndex];
                          final isCorrectOption = option == exam.correctAnswer;
                          final isSelectedOption = userPressedoption == option;

                          Color optionColor;

                          if (isSelectedOption && isCorrectOption) {
                            optionColor = Colors.green;
                          } else if (isSelectedOption && !isCorrectOption) {
                            optionColor = Colors.red;
                          } else if (!isSelectedOption && isCorrectOption) {
                            optionColor = Colors.green;
                          } else {
                            optionColor = Colors.grey.shade100;
                          }

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
                                color: Colors.black,
                              ),
                            ),
                            child: Text(
                              ' $option',
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
          Container(
            alignment: Alignment.center,
            height: mediaQuery.height * 0.055,
            width: mediaQuery.width - 50,
            decoration: BoxDecoration(
              color:
                  userPressedoption == widget.exams[questionIndex].correctAnswer
                      ? Colors.green
                      : Colors.red.shade400,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Your Choosed Option is:    $userPressedoption',
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (questionIndex > 0 && questionIndex <= widget.exams.length - 1)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize:
                        Size(mediaQuery.width * 0.25, mediaQuery.height * 0.05),
                  ),
                  onPressed: backToQuestion,
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              if (questionIndex < allQuestions.length - 1)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    fixedSize:
                        Size(mediaQuery.width * 0.25, mediaQuery.height * 0.05),
                  ),
                  onPressed: goToNextQuestion,
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
