import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:typing/result.dart';
import 'dart:async';
import 'dart:math';

import 'package:typing/window.dart';

List<int> write = [];
List<List<int>> speed = [];
List<int> nowtyp = [];

class TestScreen extends StatefulWidget {
  TestScreen({
    Key? key,
    required this.type,
  }) : super(key: key);
  String type;

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  Random rnd = Random();
  int filenum = 1;
  late Timer timer;
  int _start = 60;

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            end();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    write = [];
    speed = [];
    nowtyp = [];
    filenum = rnd.nextInt(49) + 1;
    if (widget.type == '1m') {
      _start = 60;
    } else if (widget.type == '3m') {
      _start = 3 * 60;
    } else if (widget.type == '5m') {
      _start = 5 * 60;
    }
    startTimer();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  endOne() {
    setState(() {});
  }

  end() {
    speed.add(nowtyp);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ResultScreen(
          data: speed,
          time: int.parse(widget.type[0]).toDouble(),
          train: false,
          type: widget.type,
        ),
      ),
    );
  }

  Future<List<String>> loadFile() async {
    var a = await rootBundle.loadString('assets/short/$filenum.txt');
    var b = a.split('\n');
    return b;
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.chevron_left_rounded,
                              size: 28,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 15, top: 2),
                            child: Text(
                              'Test',
                              style: TextStyle(fontSize: 21),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Time:  ${_start ~/ 60}:${_start % 60}",
                            style: const TextStyle(
                                fontSize: 16, letterSpacing: 1.4),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.volume_up_rounded),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Window(
                                    page: 1,
                                  ),
                                ),
                              );
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TestScreen(type: widget.type),
                                ),
                              );
                            },
                            icon: const Icon(Icons.restart_alt_rounded),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Divider(),
              ],
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Column(
                children: [
                  FutureBuilder(
                    future: loadFile(),
                    builder: (context, AsyncSnapshot<List<String>> snapshot) {
                      if (snapshot.hasData) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              for (var i = 0;
                                  i <= snapshot.data!.length - 2;
                                  i++)
                                TText(
                                  text: snapshot.data![i],
                                  numb: i,
                                  refresh: endOne,
                                  last: i == snapshot.data!.length - 2,
                                  ending: end,
                                ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.all(35),
                  child: Text(
                    'Line: 2, 14',
                    style: TextStyle(fontSize: 16, letterSpacing: 1.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TText extends StatefulWidget {
  TText({
    Key? key,
    required this.text,
    required this.numb,
    required this.refresh,
    required this.last,
    required this.ending,
  }) : super(key: key);

  String text;
  int numb;
  VoidCallback refresh;
  VoidCallback ending;
  bool last;

  @override
  _TTextState createState() => _TTextState();
}

class _TTextState extends State<TText> {
  String wanted = '';
  String written = '';
  String now = '';
  String after = '';
  bool done = false;
  bool visibility = false;
  bool active = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    wanted = widget.text;
    now = wanted[0];
    after = wanted.substring(1, wanted.length);

    if (write.isEmpty && widget.numb == 0 || widget.numb == 1) {
      visibility = true;
    }
    if (write.isEmpty) {
      if (widget.numb == 0) {
        active = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (write.contains(widget.numb - 1) || widget.numb == 0) {
      FocusScope.of(context).requestFocus(focusNode);
      active = true;
    }
    if (write.contains(widget.numb - 2) && !done) {
      visibility = true;
    }
    return Visibility(
      visible: visibility,
      child: RawKeyboardListener(
        autofocus: active,
        focusNode: focusNode,
        onKey: (event) {
          if (event.runtimeType == RawKeyDownEvent &&
              written.length != wanted.length) {
            print(event.logicalKey.debugName);
            print(event.physicalKey.debugName);
            print(event.character);
            if (event.logicalKey.debugName == 'Backspace') {
              if (written.isNotEmpty) {
                setState(() {
                  written = written.substring(0, written.length - 1);
                });
              }
            } else {
              setState(() {
                written += event.character ?? '';
              });
            }
            if (written.length != wanted.length) {
              setState(() {
                now = wanted.substring(written.length, written.length + 1);
                after = wanted.substring(written.length + 1, wanted.length);
              });
            } else {
              now = '';
            }
            int errors = 0;
            for (var i = 0; i < written.length; i++) {
              if (wanted[i] != written[i]) {
                errors += 1;
              }
            }
            nowtyp = [written.length, errors];
          }
          if (wanted.length == written.length) {
            setState(() {
              int errors = 0;
              for (var i = 0; i < written.length; i++) {
                if (wanted[i] != written[i]) {
                  errors += 1;
                }
              }
              speed.add([written.length, errors]);
              done = true;
              write.add(widget.numb);
              active = false;
              visibility = false;
              if (widget.last) {
                widget.ending();
              }
            });
            widget.refresh();
          }
        },
        child: Text.rich(
          TextSpan(
            children: [
              for (var i = 0; i <= written.length - 1; i++)
                TextSpan(
                  text: wanted[i],
                  style: TextStyle(
                    color: wanted[i] == written[i]
                        ? const Color(0xFF51E724)
                        : Colors.red,
                    decoration: wanted[i] == written[i]
                        ? TextDecoration.none
                        : wanted[i] == ' '
                            ? TextDecoration.underline
                            : TextDecoration.none,
                  ),
                ),
              TextSpan(
                text: now,
                style: TextStyle(
                  decoration:
                      active ? TextDecoration.underline : TextDecoration.none,
                  color: active
                      ? const Color(0xFF4A9FFF)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
              TextSpan(
                text: after,
                style: TextStyle(
                  color: active
                      ? const Color(0xFFB9B9B9)
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ],
          ),
          style: const TextStyle(
            fontSize: 20,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
