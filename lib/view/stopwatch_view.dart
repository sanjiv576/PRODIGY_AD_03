import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:stopwatch/constants/color_constants.dart';

// Design link: https://www.figma.com/design/hHk9YkdnxDOL2BoJkC0QzB/Stopwatch-UI-Design-%7C-Dark-Mode-%7C-Neumorphism-(Community)?t=HhgacC7V6BrPtNJK-0
class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  int hours = 00;
  int minutes = 00;
  int seconds = 00;
  int miliseconds = 00;

  bool isStopwatch = true;
  bool isTimerStart = false;

  Timer? _timer;

  void _resetTimer() {
    setState(() {
      minutes = 0;
      seconds = 0;
      miliseconds = 0;
    });
  }

  // void _formatTimer(int millisecondsValue) {
  //   int seconds = millisecondsValue % 60;
  // }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      setState(() {
        if (miliseconds > 60) {
          miliseconds = 0;
          seconds++;

          if (seconds > 60) {
            seconds = 0;
            minutes++;
          }
        } else {
          miliseconds++;
        }
      });
    });
  }

  void _pauseTimer() {
    log('Pause');
    _timer!.cancel();
  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width.roundToDouble();
    // double screenHeight = MediaQuery.of(context).size.height.roundToDouble();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: KColorsConstants.backgroundColor),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: KColorsConstants.backgroundColor,
          title: Text(
            isStopwatch ? 'Stopwatch' : 'Timer-60s',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ),
        body: SafeArea(
            child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
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
                        child: const SizedBox(
                          height: 300,
                          width: 300,
                          child: CircularProgressIndicator(
                            strokeCap: StrokeCap.round,
                            value: 50 / 60,
                            strokeWidth: 16,
                            backgroundColor: Colors.white,
                            color: KColorsConstants.progressBarColor,
                          ),
                        ),
                      ),
                      Text(
                        '$minutes:$seconds:$miliseconds',
                        style: const TextStyle(fontSize: 40),
                      ),
                    ],
                  ),
                ),
               
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 4,
                          shadowColor: Colors.white,
                        ),
                        onPressed: () {},
                        child: const Text('Reset All'),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape:
                              const CircleBorder(), // make circular shape of the button
                          padding: const EdgeInsets.all(12),
                          shadowColor: Colors.white,
                          elevation: 4,
                        ),
                        onPressed: () {
                          if (isTimerStart) {
                            _pauseTimer();
                          } else {
                            _startTimer();
                          }
                          setState(() {
                            isTimerStart = !isTimerStart;
                          });
                        },
                        child: Icon(
                          isTimerStart ? Icons.pause : Icons.play_arrow,
                          size: 40,
                          color: KColorsConstants.buttonColor,
                          shadows: const [
                            Shadow(
                              offset: Offset(-1, -1),
                              blurRadius: 20, // add shadow in the icon
                              color: KColorsConstants.buttonColor,
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),
                          elevation: 4,
                          shadowColor: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            isStopwatch = !isStopwatch;
                          });
                        },
                        child: Text(isStopwatch ? 'Timer-60s' : 'Stopwatch'),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )),
      ),
    );
  }
}
