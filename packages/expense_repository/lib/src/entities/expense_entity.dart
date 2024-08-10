import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class ExpenseEntity {
  String expenseId;
  Category category;
  DateTime dateTime;
  int amount;


  ExpenseEntity({
    required this.expenseId,
    required this.category,
    required this.dateTime,
    required this.amount,
  });

  Map<String, Object?> toMap() {
    return <String, dynamic>{
      'expenseId': expenseId,
      'category': category.toEntity().toMap(),
      'dateTime': dateTime,
      'amount': amount,
    };
  }

  factory ExpenseEntity.fromMap(Map<String, dynamic> map) {
    return ExpenseEntity(
      expenseId: map['expenseId'] as String,
      category: Category.fromEntity(CategoryEntity.fromMap(map['category'])),
      dateTime: (map['dateTime'] as Timestamp).toDate(),
      amount: map['amount'] as int,
    );
  }
}
