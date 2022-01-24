import 'package:flutter/material.dart';
import 'package:typing/train.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({Key? key}) : super(key: key);

  @override
  _TrainingScreenState createState() => _TrainingScreenState();
}

class _TrainingScreenState extends State<TrainingScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Beginner',
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  TrainCard(
                    title: 'J  F',
                    id: 1,
                  ),
                  TrainCard(
                    title: 'K  D',
                    id: 2,
                  ),
                  TrainCard(
                    title: 'L  S',
                    id: 3,
                  ),
                  TrainCard(
                    title: 'A  ;',
                    id: 4,
                  ),
                  TrainCard(
                    title: 'G  H',
                    id: 5,
                  ),
                  TrainCard(
                    title: 'Home Row Words',
                    id: 6,
                  ),
                  TrainCard(
                    title: 'Q  P',
                    id: 7,
                  ),
                  TrainCard(
                    title: 'W  O',
                    id: 8,
                  ),
                  TrainCard(
                    title: 'E  I',
                    id: 9,
                  ),
                  TrainCard(
                    title: 'R  U',
                    id: 10,
                  ),
                  TrainCard(
                    title: 'T  Y',
                    id: 11,
                  ),
                  TrainCard(
                    title: 'Top Row Words',
                    id: 12,
                  ),
                  TrainCard(
                    title: "Z  /",
                    id: 13,
                  ),
                  TrainCard(
                    title: 'X  .',
                    id: 14,
                  ),
                  TrainCard(
                    title: 'C  ,',
                    id: 15,
                  ),
                  TrainCard(
                    title: 'V  M',
                    id: 16,
                  ),
                  TrainCard(
                    title: 'B  N',
                    id: 17,
                  ),
                  TrainCard(
                    title: 'Bottom Row Words',
                    id: 18,
                  ),
                  TrainCard(
                    title: 'All Alphabets',
                    id: 19,
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Intermediate',
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  TrainCard(
                    title: "n't",
                    id: 20,
                  ),
                  TrainCard(
                    title: 'Symbols',
                    id: 21,
                  ),
                  TrainCard(
                    title: '"word in quotation"',
                    id: 22,
                  ),
                  TrainCard(
                    title: 'Upper case',
                    id: 23,
                  ),
                  TrainCard(
                    title: 'Symbols 2',
                    id: 24,
                  ),
                  TrainCard(
                    title: 'Number pad',
                    id: 25,
                  ),
                  TrainCard(
                    title: 'Intermediate wrap up',
                    id: 26,
                  ),
                ],
              ),
            ),
          ),
          Container(
            constraints: const BoxConstraints(maxWidth: 1000),
            child: FractionallySizedBox(
              widthFactor: 0.95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Advance',
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 1.1,
                      ),
                    ),
                  ),
                  TrainCard(
                    title: '1, a',
                    id: 27,
                  ),
                  TrainCard(
                    title: '2, s',
                    id: 28,
                  ),
                  TrainCard(
                    title: '3, d',
                    id: 29,
                  ),
                  TrainCard(
                    title: '4, f',
                    id: 30,
                  ),
                  TrainCard(
                    title: '5, g',
                    id: 31,
                  ),
                  TrainCard(
                    title: '6, h',
                    id: 32,
                  ),
                  TrainCard(
                    title: '7, j',
                    id: 33,
                  ),
                  TrainCard(
                    title: '8, k',
                    id: 34,
                  ),
                  TrainCard(
                    title: '9, l',
                    id: 35,
                  ),
                  TrainCard(
                    title: '0, ;',
                    id: 36,
                  ),
                  TrainCard(
                    title: 'number row',
                    id: 37,
                  ),
                  TrainCard(
                    title: 'number row symbols',
                    id: 38,
                  ),
                  TrainCard(
                    title: 'Advance word Test',
                    id: 39,
                  ),
                  TrainCard(
                    title: 'whole keyboard wrap up',
                    id: 40,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrainCard extends StatefulWidget {
  TrainCard({
    Key? key,
    required this.title,
    required this.id,
  }) : super(key: key);
  String title;
  int id;

  @override
  _TrainCardState createState() => _TrainCardState();
}

class _TrainCardState extends State<TrainCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 10, bottom: 15),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 20, letterSpacing: 1.05),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        onPrimary: Colors.black,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TrainScreen(
                              fileNum: widget.id,
                            ),
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(3.0),
                        child: Text(
                          'start',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
