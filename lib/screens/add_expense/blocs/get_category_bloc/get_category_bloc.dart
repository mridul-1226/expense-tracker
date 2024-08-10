import 'package:equatable/equatable.dart';
import 'package:expense_repository/expense_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'get_category_event.dart';
part 'get_category_state.dart';

class GetCategoryBloc extends Bloc<GetCategoryEvent, GetCategoryState> {
  ExpenseRepository expenseRepository;
  GetCategoryBloc(this.expenseRepository) : super(GetCategoryInitial()) {
    on<GetCategory>((event, emit) async{
      try {
        List<Category> categories = await expenseRepository.getCategory();
        emit(GetCategorySuccess(categories: categories));
      } catch (e) {
        emit(GetCategoryFailure());
      }
    });
  }
}
