import 'dart:math';
import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/views/add_expenses_screen.dart';
import 'package:expense_tracker/screens/home/bloc/get_expenses_bloc/get_expenses_bloc.dart';
import 'package:expense_tracker/screens/home/views/main_screen.dart';
import 'package:expense_tracker/screens/stats/stats_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;
  Expense? newExpense;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetExpensesBloc, GetExpensesState>(
      builder: (context, state) {
        if (state is GetExpensesSuccess) {
          return Scaffold(
            bottomNavigationBar: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              child: BottomNavigationBar(
                onTap: (value) {
                  setState(() {
                    index = value;
                  });
                },
                currentIndex: index,
                elevation: 4,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                backgroundColor: Colors.white,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.graph_square_fill),
                    label: 'Stats',
                  )
                ],
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                newExpense = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (context) =>
                              CreateCategoryBloc(FirebaseExpenseRepository()),
                        ),
                        BlocProvider(
                          create: (context) => GetCategoryBloc(
                            FirebaseExpenseRepository(),
                          )..add(
                              GetCategory(),
                            ),
                        ),
                        BlocProvider(
                          create: (context) =>
                              CreateExpenseBloc(FirebaseExpenseRepository()),
                        ),
                      ],
                      child: const AddExpensesScreen(),
                    ),
                  ),
                );

                if (newExpense != null) {
                  setState(() {
                    state.expenses.insert(0, newExpense!);
                  });
                }
              },
              shape: const CircleBorder(),
              child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Theme.of(context).colorScheme.tertiary,
                      Theme.of(context).colorScheme.secondary,
                      Theme.of(context).colorScheme.primary,
                      Theme.of(context).colorScheme.onSurface,
                    ],
                    transform: const GradientRotation(pi / 4),
                  ),
                ),
                child: const Icon(CupertinoIcons.add),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            body: index == 0
                ? MainScreen(
                    expenses: state.expenses,
                    totalExpense: newExpense == null
                        ? state.totalExpense
                        : state.totalExpense + newExpense!.amount,
                  )
                : const StatsScreen(),
            backgroundColor: Theme.of(context).colorScheme.surface,
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
