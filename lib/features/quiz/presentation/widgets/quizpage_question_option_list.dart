import 'package:flutter/material.dart';
import 'package:quiz_app/core/utils/constants/colors_constants.dart';

class QuestionOptionsList extends StatelessWidget {
  const QuestionOptionsList({
    super.key,
    required this.mediaQuery,
    required this.options,
    required this.index,
  });

  final Size mediaQuery;
  final List<String> options;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
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
        ' ${options[index]}',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.3,
        ),
      ),
    );
  }
}
