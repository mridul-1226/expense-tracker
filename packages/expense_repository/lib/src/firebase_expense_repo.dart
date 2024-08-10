import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';

class FirebaseExpenseRepository implements ExpenseRepository {
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  @override
  Future<void> createCategory(Category category) async {
    try {
      await categoryCollection
          .doc(category.categoryId)
          .set(category.toEntity().toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      return await categoryCollection.get().then(
            (value) => value.docs
                .map(
                  (e) => Category.fromEntity(
                    CategoryEntity.fromMap(
                      e.data(),
                    ),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> createExpense(Expense expense) async {
    try {
      await expenseCollection
          .doc(expense.expenseId)
          .set(expense.toEntity().toMap());
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      return await expenseCollection.get().then(
            (value) => value.docs
                .map(
                  (e) => Expense.fromEntity(
                    ExpenseEntity.fromMap(
                      e.data(),
                    ),
                  ),
                )
                .toList(),
          );
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<int> getTotalExpense() async {
    try {
      double totalExpenses = 0;
      await expenseCollection.get().then(
            // ignore: avoid_function_literals_in_foreach_calls
            (value) => value.docs.forEach(
              (element) {
                totalExpenses += element['amount'];
              },
            ),
          );
      return totalExpenses.toInt();
    } catch (e) {
      throw e.toString();
    }
  }
}
