import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_expense/create_expense_bloc.dart';
import 'package:expense_tracker/screens/add_expense/blocs/get_category_bloc/get_category_bloc.dart';
import 'package:expense_tracker/screens/add_expense/views/category_creation.dart';
import 'package:expense_tracker/utils/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddExpensesScreen extends StatefulWidget {
  const AddExpensesScreen({super.key});

  @override
  State<AddExpensesScreen> createState() => _AddExpensesScreenState();
}

class _AddExpensesScreenState extends State<AddExpensesScreen> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late Expense expense;
  bool isLoading = false;
  Color categorySelectedColor = Colors.white;
  Widget categorySelectedIcon = const Icon(
    FontAwesomeIcons.list,
    color: Colors.grey,
  );

  @override
  void initState() {
    super.initState();
    expense = Expense.empty;
    dateController.text = DateFormat('dd/MM/yyyy').format(expense.dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return BlocListener<CreateExpenseBloc, CreateExpenseState>(
      listener: (context, state) {
        if (state is CreateExpenseSuccess) {
          // Navigator.pop(context, expense);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const MyApp(),
            ),
            (route) => false,
          );
        } else if (state is CreateExpenseLoading) {
          setState(() {
            isLoading = true;
          });
        }
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(),
          body: BlocBuilder<GetCategoryBloc, GetCategoryState>(
            builder: (context, state) {
              if (state is GetCategorySuccess) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * .1, vertical: size.height * .05),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Add Expenses',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        SizedBox(
                          width: size.width * .5,
                          child: TextFormField(
                            controller: expenseController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              prefixIcon: const Icon(
                                FontAwesomeIcons.dollarSign,
                                color: Colors.grey,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        TextFormField(
                          controller: categoryController,
                          readOnly: true,
                          onTap: () async {
                            var newCategory = await categoryCreation(context);
                            setState(() {
                              state.categories.insert(0, newCategory);
                            });
                          },
                          decoration: InputDecoration(
                            fillColor: categorySelectedColor,
                            filled: true,
                            prefixIcon: categorySelectedIcon,
                            suffixIcon: const Icon(CupertinoIcons.add),
                            hintText: 'Category',
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.white,
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: const Text(
                            'Select Category :',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: 200,
                          width: size.width,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: state.categories.length,
                              itemBuilder: (context, index) {
                                return Card(
                                    child: ListTile(
                                  onTap: () {
                                    setState(() {
                                      expense.category =
                                          state.categories[index];
                                      categoryController.text =
                                          expense.category.name;
                                      categorySelectedColor =
                                          Color(expense.category.color);
                                      categorySelectedIcon = Image.asset(
                                        'assets/${expense.category.icon}.png',
                                        scale: 1.5,
                                      );
                                    });
                                  },
                                  leading: Image.asset(
                                    'assets/${state.categories[index].icon}.png',
                                    scale: 2,
                                  ),
                                  title: Text(state.categories[index].name),
                                  tileColor:
                                      Color(state.categories[index].color),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ));
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        TextFormField(
                          controller: dateController,
                          readOnly: true,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              firstDate: DateTime.now().subtract(
                                const Duration(days: 30),
                              ),
                              lastDate: DateTime.now().add(
                                const Duration(days: 30),
                              ),
                              initialDate: expense.dateTime,
                            );
                            if (selectedDate != null) {
                              setState(
                                () {
                                  expense.dateTime = selectedDate;
                                  dateController.text = DateFormat('dd/MM/yyyy')
                                      .format(expense.dateTime);
                                },
                              );
                            }
                          },
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Icon(
                              FontAwesomeIcons.dollarSign,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 60),
                        isLoading
                            ? const CircularProgressIndicator()
                            : CustomButton(
                                onPressed: () {
                                  expense.expenseId = const Uuid().v1();
                                  expense.amount =
                                      int.parse(expenseController.text);
                                  context.read<CreateExpenseBloc>().add(
                                        CreateExpense(
                                          expense: expense,
                                        ),
                                      );
                                },
                              ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
