import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/core/routes/routes.dart';
import 'package:quiz_app/features/quiz/data/model/quiz_data_model.dart';
import 'package:quiz_app/features/quiz/presentation/page/view_detail_page.dart';

class QuizHeader extends StatefulWidget {
  final int seconds;
  final String type;
  final int questionIndex;
  final List<ExamModel> data;
  final List<String> options;
  final int point;
  const QuizHeader(this.seconds, this.type, this.questionIndex, this.data,
      this.options, this.point,
      {super.key});

  @override
  State<QuizHeader> createState() => _QuizHeaderState();
}

class _QuizHeaderState extends State<QuizHeader> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    Size mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
          height: mediaQuery.height * 0.04,
          width: mediaQuery.width * 0.2,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '${widget.seconds}',
                maxLines: 1,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const Icon(
                CupertinoIcons.timer_fill,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                overflow: TextOverflow.ellipsis,
                widget.type.toUpperCase(),
                style: const TextStyle(
                  fontSize: 20,
                  letterSpacing: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.01,
            ),
            Text('${widget.questionIndex + 1} of ${widget.data.length}'),
          ],
        ),
        Container(
          height: mediaQuery.height * 0.04,
          width: mediaQuery.width * 0.12,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextButton.icon(
            label: const Text(''),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Routes().category);
            },
            icon: const Icon(
              CupertinoIcons.xmark,
              size: 22,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
