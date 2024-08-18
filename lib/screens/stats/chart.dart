import 'dart:math';

import 'package:expense_repository/expense_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class MyBarChart extends StatefulWidget {
  const MyBarChart({super.key, required this.categories});

  final List<Category> categories;

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
            getTitlesWidget: bottomTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 80,
            getTitlesWidget: leftTitles,
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      gridData: const FlGridData(show: false),
      barGroups: barGroups(),
    );
  }

  List<BarChartGroupData> barGroups() =>
      List.generate(widget.categories.length > 5 ? 5 : widget.categories.length,
          (i) {
        return makeGroupData(i, widget.categories[i].totalExpense.toDouble());
      });

  Widget bottomTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );

    Widget text = Text(
      widget.categories[value.toInt()].name,
      style: style,
    );

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

    if (widget.categories.isNotEmpty && value == widget.categories[0].totalExpense) {
      text = const Text('');
    } else {
      text = Text(
        '\$ ${value.toInt()}',
        style: style,
      );
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
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
            toY: widget.categories.isNotEmpty
                ? widget.categories[0].totalExpense.toDouble()
                : 5,
          ),
        ),
      ],
    );
  }
}
