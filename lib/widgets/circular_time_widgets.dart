
// upper part
import 'package:flutter/material.dart';

import '../constants/color_constants.dart';

class CircularTimeWidgets extends StatelessWidget {
  const CircularTimeWidgets({
    super.key,
    required this.minutes,
    required this.seconds,
    required this.miliseconds,
    required this.hours,
    required this.isStopwatch,
  });

  final String hours;
  final String minutes;
  final String seconds;
  final String miliseconds;
  final bool isStopwatch;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 145, 132, 132),
                  // color: Colors.pink,
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: Offset(
                    -10,
                    -12,
                  ),
                ),
                BoxShadow(
                  color: Color(0xFF141414),
                  spreadRadius: 2,
                  blurRadius: 12,
                  offset: Offset(
                    6,
                    4,
                  ),
                ),
              ],
            ),
            child: SizedBox(
              height: 300,
              width: 300,
              child: CircularProgressIndicator(
                strokeCap: StrokeCap.round,
                value: double.parse(seconds) / 60,
                strokeWidth: 16,
                backgroundColor: Colors.white,
                color: KColorsConstants.progressBarColor,
              ),
            ),
          ),
          Text(
            isStopwatch
                ? '$hours d: $minutes:$seconds.$miliseconds'
                : '$seconds.$miliseconds',
            style: const TextStyle(fontSize: 40),
          ),
        ],
      ),
    );
  }
}
