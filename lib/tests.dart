import 'package:path_provider/path_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:typing/test.dart';
import 'dart:io';

class Tests extends StatefulWidget {
  const Tests({Key? key}) : super(key: key);

  @override
  _TestsState createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 0.95,
      heightFactor: 1,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TestCard(
              title: '1 minut Test',
              type: '1m',
              file: '1.txt',
            ),
            const SizedBox(height: 25),
            TestCard(
              title: '3 minut Test',
              type: '3m',
              file: '2.txt',
            ),
            const SizedBox(height: 25),
            TestCard(
              title: '5 minut Test',
              type: '5m',
              file: '3.txt',
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}

class TestCard extends StatefulWidget {
  TestCard({
    Key? key,
    required this.title,
    required this.type,
    required this.file,
  }) : super(key: key);
  String title;
  String type;
  String file;

  @override
  _TestCardState createState() => _TestCardState();
}

class _TestCardState extends State<TestCard> {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/test.txt');
  }

  Future<List<String>> readData(type) async {
    try {
      final file = await _localFile;
      final contents = await file.readAsLines();
      List<String> a = [];
      for (var i in contents) {
        if (i.split(',')[0] == type) {
          a.add(i);
        }
      }
      return a;
    } catch (e) {
      return [];
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 550, maxHeight: 370),
      decoration: BoxDecoration(
        color: const Color(0xFF3D3D3D),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: FutureBuilder(
                  future: readData(widget.type),
                  builder: (context, AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.data!.length <= 1) {
                      return TestChart(
                        data: const [
                          FlSpot(0, 1),
                        ],
                      );
                    } else {
                      return TestChart(
                        data: [
                          for (var i = 0; i <= snapshot.data!.length - 1; i++)
                            FlSpot(
                                i.toDouble(),
                                (int.parse(snapshot.data![i].split(',')[1]))
                                    .toDouble()),
                        ],
                      );
                    }
                  }),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 15, bottom: 15, top: 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 80,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.black),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TestScreen(
                            type: widget.type,
                          ),
                        ),
                      );
                    },
                    child: const Text('start'),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TestChart extends StatefulWidget {
  TestChart({Key? key, required this.data}) : super(key: key);
  List<FlSpot> data;

  @override
  _TestChartState createState() => _TestChartState();
}

class _TestChartState extends State<TestChart> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(18),
            ),
            color: Color(0xFF1F1F1F)),
        child: Padding(
          padding: const EdgeInsets.only(
              right: 18.0, left: 12.0, top: 24, bottom: 12),
          child: LineChart(
            mainData(),
          ),
        ),
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xFF474747),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xFF474747),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
              case 100:
                return '100';
            }
            return '';
          },
          margin: 5,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
              case 60:
                return '60';
              case 70:
                return '70';
            }
            return '';
          },
          reservedSize: 32,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 70,
      lineBarsData: [
        LineChartBarData(
          spots: widget.data,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}
