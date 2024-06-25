import 'package:flutter/material.dart';
import 'view/splash_view.dart';
import 'view/stopwatch_view.dart';

import 'constants/color_constants.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark()
          .copyWith(scaffoldBackgroundColor: KColorsConstants.backgroundColor),
      routes: {
        '/': (context) => const SplashView(),
        '/home': (context) => const StopwatchView(),
      },
      initialRoute: '/',
    );
  }
}
