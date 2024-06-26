import 'dart:async';

import 'package:flutter/material.dart';

import '../constants/color_constants.dart';
import '../widgets/circular_time_widgets.dart';

// Design link: https://www.figma.com/design/hHk9YkdnxDOL2BoJkC0QzB/Stopwatch-UI-Design-%7C-Dark-Mode-%7C-Neumorphism-(Community)?t=HhgacC7V6BrPtNJK-0

class StopwatchView extends StatefulWidget {
  const StopwatchView({super.key});

  @override
  State<StopwatchView> createState() => _StopwatchViewState();
}

class _StopwatchViewState extends State<StopwatchView> {
  final Stopwatch _stopwatch = Stopwatch();

  bool isStopwatch = true;
  bool isTimerStart = false;

  Timer? _timer;

  void _resetTimer() {
    _stopwatch.reset();
    setState(() {});
  }

  void _startTimer() {
    _stopwatch.start();
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  void _pauseTimer() {
    _stopwatch.stop();
    _timer!.cancel();
  }

  void _toggleStartAndPause() {
    // pause timer if the timer is running otherwise, start it
    if (isTimerStart) {
      _pauseTimer();
    } else {
      _startTimer();
    }
    setState(() {
      isTimerStart = !isTimerStart;
    });
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = _stopwatch.elapsed;
    final hours = elapsed.inHours;
    final minutes = elapsed.inMinutes % 60;
    final seconds = elapsed.inSeconds % 60;
    final milliseconds = elapsed.inMilliseconds % 1000;

    return Scaffold(
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
              CircularTimeWidgets(
                hours: hours.toString().padLeft(2, '0'),
                minutes: minutes.toString().padLeft(2, '0'),
                seconds: seconds.toString().padLeft(2, '0'),
                miliseconds: milliseconds.toString().padLeft(2, '0'),
                isStopwatch: isStopwatch,
              ),

              // lower part
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // reset button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: Colors.white,
                      ),
                      onPressed: () {
                        _resetTimer();

                        //  pause the timer
                        setState(() {
                          isTimerStart = false;
                        });
                        _pauseTimer();

                        // _toggleStartAndPause();
                      },
                      child: const Text('Reset All'),
                    ),

                    // start and pause buttons

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape:
                            const CircleBorder(), // make circular shape of the button
                        padding: const EdgeInsets.all(12),
                        shadowColor: Colors.white,
                        elevation: 4,
                      ),
                      onPressed: _toggleStartAndPause,
                      child: Icon(
                        // show pause icon when timer is running
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

                    // stopwatch or timer-60s button

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        elevation: 4,
                        shadowColor: Colors.white,
                      ),
                      onPressed: () {
                        _resetTimer();

                        // pause the stopwatch
                        _pauseTimer();

                        setState(() {
                          isStopwatch = !isStopwatch;
                          // stop timer
                          isTimerStart = false;
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
    );
  }
}
