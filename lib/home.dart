import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DefaultTextStyle(
          style: const TextStyle(
            fontSize: 30.0,
          ),
          child: AnimatedTextKit(
            pause: const Duration(milliseconds: 1500),
            animatedTexts: [
              TypewriterAnimatedText(
                'Learn to type',
                speed: const Duration(milliseconds: 300),
              ),
              TypewriterAnimatedText(
                'Train your fingers',
                speed: const Duration(milliseconds: 300),
              ),
              TypewriterAnimatedText(
                'Test your typing speed',
                speed: const Duration(milliseconds: 300),
              ),
              TypewriterAnimatedText(
                'Type faster',
                speed: const Duration(milliseconds: 300),
              ),
            ],
            onTap: () {
              print("Tap Event");
            },
          ),
        ),
      ],
    );
  }
}
