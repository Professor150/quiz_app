import 'package:flutter/material.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({
    Key? key,
    required this.mediaQuery,
    required this.exam,
    required this.questionIndex,
    required this.userPressedOption,
    required this.questionOptions,
  }) : super(key: key);

  final Size mediaQuery;
  final ExamModel exam;
  final int questionIndex;
  final String userPressedOption;
  final Map<int, List> questionOptions;
  final List<String> abcd = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: mediaQuery.height * 0.55,
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
                    final option = questionOptions[questionIndex]![optionIndex];
                    final isCorrectOption = option == exam.correctAnswer;
                    final isSelectedOption = userPressedOption == option;

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
                      height: mediaQuery.height * 0.06,
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
                        maxLines: 1,
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
    );
  }
}
