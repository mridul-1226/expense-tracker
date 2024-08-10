import 'package:expense_tracker/model/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

List<TransactionModel> transactionData = [
  TransactionModel(
    color: Colors.yellow[700]!,
    icon: const FaIcon(FontAwesomeIcons.burger, color: Colors.white,),
    title: 'Food',
    expense: '35',
    date: 'Today',
  ),
  TransactionModel(
    color: Colors.purple,
    icon: const FaIcon(FontAwesomeIcons.bagShopping, color: Colors.white,),
    title: 'Shopping',
    expense: '180',
    date: 'Today',
  ),
  TransactionModel(
    color: Colors.green,
    icon: const FaIcon(FontAwesomeIcons.heartCircleCheck, color: Colors.white,),
    title: 'Health',
    expense: '60',
    date: 'Yesterday',
  ),
  TransactionModel(
    color: Colors.blue,
    icon: const FaIcon(FontAwesomeIcons.plane, color: Colors.white,),
    title: 'Travel',
    expense: '130',
    date: 'Yesterday',
  ),
  TransactionModel(
    color: Colors.red,
    icon: const FaIcon(FontAwesomeIcons.house, color: Colors.white,),
    title: 'Rent',
    expense: '150',
    date: 'Yesterday',
  ),
];
