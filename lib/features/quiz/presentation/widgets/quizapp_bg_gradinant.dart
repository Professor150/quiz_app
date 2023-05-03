import 'package:flutter/material.dart';

import '../../../../core/utils/constants/colors_constants.dart';


class QuizBgColor extends StatelessWidget {
  final Widget widget;
  QuizBgColor(this.widget);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.amber.shade200, darkBlue],
        ),
      ),
      child: widget,
    );
  }
}
