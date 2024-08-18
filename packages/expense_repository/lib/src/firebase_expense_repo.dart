import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:intl/intl.dart';

class FirebaseExpenseRepository implements ExpenseRepository {
  final categoryCollection =
      FirebaseFirestore.instance.collection('categories');
  final expenseCollection = FirebaseFirestore.instance.collection('expenses');

  final budgetCollection = FirebaseFirestore.instance.collection('budget');

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
      List<Category> categories = await categoryCollection.get().then(
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

          categories.sort((a, b) => b.totalExpense.compareTo(a.totalExpense),);
          return categories;
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

      var categoryDoc = categoryCollection.doc(expense.category.categoryId);
      DocumentSnapshot snapshot = await categoryDoc.get();
      if (!snapshot.exists) throw Exception('Document does not exist');
      var data = snapshot.data() as Map<String, dynamic>?;
      categoryDoc
          .update({'totalExpense': data?['totalExpense'] + expense.amount});
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<List<Expense>> getExpenses() async {
    try {
      List<Expense> expenses =
          await expenseCollection.get().then((value) => value.docs
              .map(
                (e) => Expense.fromEntity(
                  ExpenseEntity.fromMap(
                    e.data(),
                  ),
                ),
              )
              .toList());
      expenses.sort(
        (a, b) => b.dateTime.compareTo(a.dateTime),
      );
      return expenses;
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

  @override
  Future<void> setMonthlyBudget(int budget) async {
    // Get the current month and year
    DateTime now = DateTime.now();
    String month = DateFormat('MM').format(now); // e.g., '08' for August
    String year = DateFormat('yyyy').format(now); // e.g., '2024'

    // Create a document ID like 'budget_08_2024'
    String documentId = 'budget_${month}_$year';

    // Reference to the user's budget for the specific month
    await budgetCollection.doc(documentId).set({
      'month': month,
      'year': year,
      'budget': budget,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  @override
  Future<int?> getMonthlyBudget() async {
    // Get the current month and year
    DateTime now = DateTime.now();
    String month = DateFormat('MM').format(now); // e.g., '08' for August
    String year = DateFormat('yyyy').format(now); // e.g., '2024'

    // Create a document ID like 'budget_08_2024'
    String documentId = 'budget_${month}_$year';

    // Fetch the budget document
    DocumentSnapshot snapshot = await budgetCollection.doc(documentId).get();

    if (snapshot.exists) {
      var data = snapshot.data() as Map<String, dynamic>;
      return data['budget'] as int?;
    } else {
      return null;
    }
  }
}
