import 'package:flutter/material.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.black,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(text: 'Your typing speed is '),
                    TextSpan(
                      text: '40WPM ',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(text: 'with accuracy of '),
                    TextSpan(
                      text: '95%.',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  style: TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.8,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
