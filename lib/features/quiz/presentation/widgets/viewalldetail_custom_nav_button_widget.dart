
import 'package:flutter/material.dart';

class NavButtonWidget extends StatelessWidget {
  const NavButtonWidget({
    Key? key,
    required this.mediaQuery,
    required this.navQuestion,
    required this.title,
  }) : super(key: key);

  final Size mediaQuery;
  final VoidCallback navQuestion;
  final String title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        fixedSize: Size(mediaQuery.width * 0.25, mediaQuery.height * 0.05),
      ),
      onPressed: navQuestion,
      child: Text(
        title,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
