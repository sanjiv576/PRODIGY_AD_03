import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 4), () {
      Navigator.popAndPushNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LottieBuilder.asset('assets/animation.json'),
                const SizedBox(height: 8),
                Text(
                  'Developed by Sanjiv Shrestha',
                  style: Theme.of(context).textTheme.bodyLarge,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
