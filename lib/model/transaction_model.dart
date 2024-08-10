import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TransactionModel {
  final Color color;
  final FaIcon icon;
  final String title;
  final String expense;
  final String date;

  TransactionModel({
    required this.color,
    required this.icon,
    required this.title,
    required this.expense,
    required this.date,
  });
}
