import 'package:expense_repository/expense_repository.dart';

abstract class ExpenseRepository {
  Future<void> createCategory(Category category);

  Future<List<Category>> getCategory();

  Future<void> createExpense(Expense expense);

  Future<List<Expense>> getExpenses();

  Future<int> getTotalExpense();

  Future<void> setMonthlyBudget(int budget);

  Future<int?> getMonthlyBudget();
}
