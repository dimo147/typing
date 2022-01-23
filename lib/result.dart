import 'dart:io';
import 'package:typing/consts.dart';
import 'package:typing/test.dart';
import 'package:typing/train.dart';
import 'package:typing/window.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({
    Key? key,
    required this.data,
    required this.time,
    required this.train,
    required this.type,
  }) : super(key: key);
  List<List<int>> data;
  double time;
  bool train;
  String type;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  int wpm = 0;
  int acc = 0;
  int stars = 0;
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
    if (acc >= 90 && wpm >= 20) {
      stars += 1;
    }
    if (acc >= 95 && wpm >= 25) {
      stars += 1;
    }
    if (wpm >= 30) {
      stars += 1;
    }
  }

  inserData() async {
    if (!widget.train) {
      final file = await localFile;
      file.writeAsString('${widget.time.toInt()}m, $wpm, $acc\n',
          mode: FileMode.append);
      try {
        final file = await localFile;
        final contents = await file.readAsString();
        print(contents);
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xff212121),
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
              StarRow(stars: stars),
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
                          builder: (context) => Window(
                            page: widget.train ? 2 : 1,
                          ),
                        ),
                      );
                      if (!widget.train) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TestScreen(type: widget.type),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainScreen(
                              fileNum: int.parse(widget.type.split(' ')[0]),
                            ),
                          ),
                        );
                      }
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
                            builder: (context) => Window(
                              page: widget.train ? 2 : 1,
                            ),
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

class StarRow extends StatefulWidget {
  StarRow({Key? key, required this.stars}) : super(key: key);
  int stars;

  @override
  _StarRowState createState() => _StarRowState();
}

class _StarRowState extends State<StarRow> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedStar(
          del: 50,
          fill: widget.stars >= 1,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 50),
          child: AnimatedStar(
            del: 700,
            fill: widget.stars >= 2,
          ),
        ),
        AnimatedStar(
          del: 1200,
          fill: widget.stars == 3,
        ),
      ],
    );
  }
}

class AnimatedStar extends StatefulWidget {
  AnimatedStar({
    Key? key,
    required this.del,
    required this.fill,
  }) : super(key: key);
  int del;
  bool fill;

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
          Stars(
            del: widget.del,
            fill: widget.fill,
          ),
        ],
      ),
    );
  }
}

class Stars extends StatefulWidget {
  Stars({Key? key, required this.del, required this.fill}) : super(key: key);
  int del;
  bool fill;

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
      child: Icon(
        widget.fill ? Icons.star : Icons.star_border,
        size: 100,
        color: Colors.yellow,
      ),
    );
  }
}
