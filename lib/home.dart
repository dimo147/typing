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
    return const LineChartSample2();
  }
}

class LineChartSample2 extends StatefulWidget {
  const LineChartSample2({Key? key}) : super(key: key);

  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
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
          spots: const [
            FlSpot(0, 36),
            FlSpot(1, 32),
            FlSpot(2, 35),
            FlSpot(3, 33),
            FlSpot(4, 40),
            FlSpot(5, 35),
            FlSpot(6, 42),
            FlSpot(7, 35),
            FlSpot(8, 38),
            FlSpot(9, 40),
            FlSpot(10, 36),
          ],
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
