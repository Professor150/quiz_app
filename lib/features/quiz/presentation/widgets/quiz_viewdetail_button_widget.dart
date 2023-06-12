// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '../../data/model/quiz_data_model.dart';
// import '../page/view_detail_page.dart';

// class ViewDteailButtonWidget extends StatelessWidget {
//   const ViewDteailButtonWidget({
//     super.key,
//     required this.currentQuestionIndex,
//     required this.points,
//     required this.userCorrectAnswer,
//     required this.totalAnswered,
//     required this.wrongAnswer,
//     required this.correctAnsweredQuestions,
//     required this.wrongAnswerdQuestions,
//     required this.userTappedOption,
//     required this.options,
//     required this.questionOptions,
//     required this.exams,
//   });
//   final List<ExamModel> exams;
//   final int currentQuestionIndex;
//   final int points;
//   final int userCorrectAnswer;
//   final int totalAnswered;
//   final int wrongAnswer;
//   final List<String> correctAnsweredQuestions;
//   final List<String> wrongAnswerdQuestions;
//   final List<String> userTappedOption;
//   final List<String> options;
//   final Map<int, List> questionOptions;

//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//       child: const Text(
//         'View Detail',
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       onPressed: () {
//         Future.delayed(
//             // ignore: prefer_const_constructors
//             Duration(microseconds: 300), () {
//           Navigator.of(context).pushReplacement(
//             MaterialPageRoute(
//               builder: (_) => ViewDetailPage(
//                 exams: exams,
//                 currentQuestionIndex: currentQuestionIndex,
//                 points: points,
//                 correctAnswer: userCorrectAnswer,
//                 totalAnswered: totalAnswered,
//                 wrongAnswer: wrongAnswer,
//                 correctAnsweredQuestions: correctAnsweredQuestions,
//                 wrongQuestions: wrongAnswerdQuestions,
//                 userTappedOption: userTappedOption,
//                 options: options,
//                 questionOptions: questionOptions,
//                 alloptions: [],
//               ),
//             ),
//           );
//         });
//       },
//     );
//   }
// }
