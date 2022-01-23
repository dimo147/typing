import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:typing/window.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.92,
      heightFactor: 0.7,
      child: Row(
        children: [
          Stack(
            children: [
              SizedBox(
                width: 500,
                height: 1000,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Test Your Typing Skills',
                      style: TextStyle(
                        fontSize: 32,
                      ),
                    ),
                    SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const SizedBox(width: 5),
                          const Text(
                            'Learn to type',
                            style: TextStyle(fontSize: 32.0),
                          ),
                          const SizedBox(width: 10),
                          DefaultTextStyle(
                            style: const TextStyle(
                              fontSize: 28,
                            ),
                            child: AnimatedTextKit(
                              pause: const Duration(milliseconds: 1500),
                              animatedTexts: [
                                RotateAnimatedText(
                                  'Faster',
                                  duration: const Duration(seconds: 2),
                                ),
                                TypewriterAnimatedText(
                                  'More Accurate',
                                  speed: const Duration(milliseconds: 200),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'Test your typing skills with 1, 3 and 5 minut tests and increase your typing speed and accuracy with trainnings!',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.08,
                        color: Colors.white70,
                        wordSpacing: 1.2,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Window(page: 1),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.white, onPrimary: Colors.black),
                      child: const Padding(
                        padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: Text('Start Now'),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 300),
                child: RotationTransition(
                  turns: const AlwaysStoppedAnimation(-50 / 360),
                  child: Image.asset(
                    'assets/images/keyboard_1.png',
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
