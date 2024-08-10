import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key});

  @override
  State<MyBarChart> createState() => _MyBarChartState();
}

class _MyBarChartState extends State<MyBarChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(barChartData());
  }

  BarChartData barChartData() {
    return BarChartData(
      titlesData: FlTitlesData(
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: bottomTitles,),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true, reservedSize: 60, getTitlesWidget: leftTitles),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: barGroups(),
    );
  }

  List<BarChartGroupData> barGroups() => List.generate(8, (i) {
        switch (i) {
          case 0:
            return makeGroupData(0, 2);
          case 1:
            return makeGroupData(1, 3);
          case 2:
            return makeGroupData(2, 2);
          case 3:
            return makeGroupData(3, 4.5);
          case 4:
            return makeGroupData(4, 3.8);
          case 5:
            return makeGroupData(5, 1.5);
          case 6:
            return makeGroupData(6, 4);
          case 7:
            return makeGroupData(7, 3.8);
          default:
            return throw Error();
        }
      });

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;

    switch (value.toInt()) {
      case 0:
        text = const Text(
          '01',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          '02',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          '03',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          '04',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          '05',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          '06',
          style: style,
        );
        break;
      case 6:
        text = const Text(
          '07',
          style: style,
        );
        break;
      case 7:
        text = const Text(
          '08',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text;

    switch (value) {
      case 0:
        text = const Text(
          '\$ 0K',
          style: style,
        );
        break;
      case 1:
        text = const Text(
          '\$ 1K',
          style: style,
        );
        break;
      case 2:
        text = const Text(
          '\$ 2K',
          style: style,
        );
        break;
      case 3:
        text = const Text(
          '\$ 3K',
          style: style,
        );
        break;
      case 4:
        text = const Text(
          '\$ 4K',
          style: style,
        );
        break;
      case 5:
        text = const Text(
          '\$ 5K',
          style: style,
        );
        break;
      default:
        text = const Text(
          '',
          style: style,
        );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }




  BarChartGroupData makeGroupData(int x, double y) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSurface,
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.tertiary,
            ],
            transform: const GradientRotation(pi / 40),
          ),
          width: 10,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            color: Colors.grey.shade300,
            toY: 5,
          ),
        ),
      ],
    );
  }
}
