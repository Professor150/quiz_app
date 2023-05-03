import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/constants/text_style.dart';

class QuizHeader extends StatefulWidget {
  final int seconds;

  QuizHeader(this.seconds);

  @override
  State<QuizHeader> createState() => _QuizHeaderState();
}

class _QuizHeaderState extends State<QuizHeader> {
  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: IconButton(
              onPressed: () {
                
              },
              icon: const Icon(
                CupertinoIcons.home,
                color: Colors.white,
                size: 22,
              )),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            normalText(
                color: Colors.white, size: 22, text: "${widget.seconds}"),
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                value: widget.seconds / 30,
                valueColor: const AlwaysStoppedAnimation(Colors.white),
              ),
            ),
          ],
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white, width: 2),
          ),
          child: TextButton.icon(
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
            icon: isFavorite
                ? Icon(Icons.favorite_border,
                    color: Colors.white, size: mediaQuery.height * 0.03)
                : Icon(
                    Icons.favorite,
                    color: Colors.red,
                  ),
            label: normalText(
                color: Colors.white,
                size: mediaQuery.height * 0.02,
                text: "Like"),
          ),
        ),
      ],
    );
  }
}
