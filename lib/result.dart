import 'dart:io';
import 'package:typing/test.dart';
import 'package:typing/tests.dart';
import 'package:typing/window.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    Key? key,
    required this.data,
    required this.time,
  }) : super(key: key);
  List<List<int>> data;
  int time;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int wpm = 0;
  int acc = 0;
  @override
  void initState() {
    super.initState();
    int entries = 0;
    int errors = 0;
    for (var i in widget.data) {
      entries += i[0];
      errors += i[1];
    }
    var a = entries / 5;
    double speed = a / widget.time;
    var b = entries - errors;
    double c = b / entries;
    var accuracy = (c * 100).toInt();
    setState(() {
      wpm = speed.toInt();
      acc = accuracy;
    });
    inserData();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.txt');
  }

  inserData() async {
    final file = await _localFile;
    file.writeAsString('${widget.time}m, $wpm, $acc\n', mode: FileMode.append);
    try {
      final file = await _localFile;
      final contents = await file.readAsString();
      print(contents);
    } catch (e) {
      print(e);
    }
  }

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
            children: [
              const Spacer(
                flex: 2,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedStar(del: 50),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
                    child: AnimatedStar(del: 700),
                  ),
                  AnimatedStar(del: 1200),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(text: 'Your typing speed is '),
                    TextSpan(
                      text: '${wpm}WPM ',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const TextSpan(text: 'with accuracy of '),
                    TextSpan(
                      text: '$acc%.',
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  style: const TextStyle(
                    fontSize: 20,
                    letterSpacing: 1.8,
                  ),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Tests(),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestScreen(type: '1m'),
                        ),
                      );
                    },
                    child: const Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Text(
                        'Try Again',
                        style:
                            TextStyle(color: Colors.white, letterSpacing: 1.3),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 50, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Window(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 12,
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(7, 6, 0, 6),
                        child: Row(
                          children: const [
                            Text(
                              'Done',
                              style: TextStyle(
                                letterSpacing: 1.2,
                              ),
                            ),
                            Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedStar extends StatefulWidget {
  AnimatedStar({Key? key, required this.del}) : super(key: key);
  int del;

  @override
  _AnimatedStarState createState() => _AnimatedStarState();
}

class _AnimatedStarState extends State<AnimatedStar>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      value: 0.0,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    Future.delayed(Duration(milliseconds: widget.del), _controller.forward);
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stars(del: widget.del),
        ],
      ),
    );
  }
}

class Stars extends StatefulWidget {
  Stars({Key? key, required this.del}) : super(key: key);
  int del;

  @override
  _StarsState createState() => _StarsState();
}

class _StarsState extends State<Stars> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
      reverseDuration: const Duration(seconds: 0),
    );
    super.initState();
    Future.delayed(
      Duration(milliseconds: widget.del),
      _controller.forward,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
      child: const Icon(
        Icons.star,
        size: 100,
        color: Colors.yellow,
      ),
    );
  }
}
