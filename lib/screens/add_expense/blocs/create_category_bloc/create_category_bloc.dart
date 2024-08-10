import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_repository/expense_repository.dart';

part 'create_category_event.dart';
part 'create_category_state.dart';

class CreateCategoryBloc extends Bloc<CreateCategoryEvent, CreateCategoryState> {
  final ExpenseRepository expenseRepository;
  CreateCategoryBloc(this.expenseRepository) : super(CreateCategoryInitial()) {
    on<CreateCategory>((event, emit) async{
      try {
        await expenseRepository.createCategory(event.category);
        emit(CreateCategorySuccess());
      } catch (e) {
        emit(CreateCategoryFailure());
      }
    });
  }
}
