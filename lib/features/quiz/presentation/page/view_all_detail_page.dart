import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/features/quiz/data/data%20source/remote/api_service.dart';
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
  List<String> options;
  final Map<String, List<String>> optionsMap;
  final List<String> currentQuestionOptionsIndex;
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
    required this.optionsMap,
    required this.currentQuestionOptionsIndex,
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

  // @override
  // void initState() {
  //   super.initState();
  //   for (int i = 0; i < widget.userPreference.length; i++) {
  //     print("the data is ${widget.userPreference[i].question}");
  //     print("the data is ${widget.userPreference[i].option}");
  //   }
  // }

  // Example usage
  Future<void> initializeQuiz() async {
    print('data us comeing ');
    final quizProvider = context.read<FetchAllQuizProvider>();

    if (quizProvider.exams.isEmpty) {
      try {
        await quizProvider.getQuiz();
        setState(() {
          questionIndex = 0;

          // Populate options map for each question
          final optionsMap =
              Map.fromEntries(quizProvider.exams.asMap().entries.map(
                    (entry) => MapEntry(
                      entry.key,
                      List.from(entry.value.options),
                    ),
                  ));
        });
      } catch (error) {
        // Handle error
      }
    }
  }

  int index = 0;
  @override
  Widget build(BuildContext context) {
    final optionList = widget.currentQuestionOptionsIndex[index];
    final forOptions = widget.exams[questionIndex].options;

    final userPressedoption = widget.userTappedOption[questionIndex];
    final List<String> allQuestions = []
      ..addAll(widget.wrongQuestions)
      ..addAll(widget.correctAnsweredQuestions);
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
              ' Attempted Questions: ${allQuestions.length}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: mediaQuery.height * 0.4,
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                final exam = widget.exams[questionIndex];
                final shuffledOptions = List<String>.from(exam.options)
                  ..shuffle();
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
                        // itemCount: optionsMaps.length,
                        itemCount: optionList.length,
                        itemBuilder: (context, index) {
                          print(widget.options);
                          // final option = exam.options[index];
                          // final option = optionsMaps[index];
                          final option = optionList[index];
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
                                color: optionColor,
                              ),
                            ),
                            child: Text(
                              ' ${option}',
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
              border: Border.all(
                  color: userPressedoption ==
                          widget.exams[questionIndex].correctAnswer
                      ? Colors.green
                      : Colors.red),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              maxLines: 1,
              '  Your Choosed Option is:  $userPressedoption',
              style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.3,
                  color: Colors.white),
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
