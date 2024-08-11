import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'get_expenses_event.dart';
part 'get_expenses_state.dart';

class GetExpensesBloc extends Bloc<GetExpensesEvent, GetExpensesState> {
  final ExpenseRepository expenseRepository;
  GetExpensesBloc(this.expenseRepository) : super(GetExpensesInitial()) {
    on<GetExpenses>((event, emit) async {
      emit(GetExpensesLoading());
      try {
        List<Expense> expenses = await expenseRepository.getExpenses();
        int totalExpense = await expenseRepository.getTotalExpense();
        emit(
          GetExpensesSuccess(
            totalExpense: totalExpense,
            expenses: expenses,
          ),
        );
      } catch (e) {
        emit(GetExpensesFailure());
      }
    });
  }
}
