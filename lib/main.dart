import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:expense_tracker/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/home/views/home_screen.dart';
import 'package:expense_tracker/simple_bloc_observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense Tracker',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade100,
          onSurface: Colors.black,
          primary: const Color(0xFF7303c0),
          secondary: const Color(0xFFec38bc),
          tertiary: const Color(0xFFfdeff9),
          outline: Colors.grey[400],
        ),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => GetExpensesBloc(FirebaseExpenseRepository())
              ..add(GetExpenses()),
          ),
          BlocProvider(
            create: (context) => GetCategoryBloc(FirebaseExpenseRepository())
              ..add(GetCategory()),
          ),
        ],
        child: const HomeScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
