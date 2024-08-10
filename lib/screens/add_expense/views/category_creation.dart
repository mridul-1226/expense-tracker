import 'package:expense_repository/expense_repository.dart';
import 'package:expense_tracker/screens/add_expense/blocs/create_category_bloc/create_category_bloc.dart';
import 'package:expense_tracker/utils/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:uuid/uuid.dart';

Future categoryCreation(BuildContext context) {
  List<String> categoriesIcons = [
    'entertainment',
    'food',
    'home',
    'pet',
    'shopping',
    'tech',
    'travel',
  ];
  return showDialog(
    context: context,
    builder: (ctx) {
      bool isVisible = false;
      String selectedIcon = '';
      Color pickedColor = Colors.white;

      TextEditingController categoryNameController = TextEditingController();
      TextEditingController categoryIconController = TextEditingController();
      TextEditingController categoryColorController = TextEditingController();
      Category category = Category.empty;

      return BlocProvider.value(
        value: context.read<CreateCategoryBloc>(),
        child: BlocListener<CreateCategoryBloc, CreateCategoryState>(
          listener: (context, state) {
            if (state is CreateCategorySuccess) {
              Navigator.pop(context, category);
            }
          },
          child: StatefulBuilder(
            builder: (ctx, setState) => AlertDialog(
              title: const Text(
                'Category',
                textAlign: TextAlign.center,
              ),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(ctx).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: categoryNameController,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryIconController,
                        readOnly: true,
                        onTap: () {
                          setState(
                            () => isVisible = !isVisible,
                          );
                        },
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          hintText: 'Icon',
                          suffixIcon: const Icon(
                            CupertinoIcons.chevron_down,
                            size: 16,
                          ),
                          prefixIcon: selectedIcon != ''
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Image.asset('assets/$selectedIcon.png'),
                                )
                              : const SizedBox(),
                          border: OutlineInputBorder(
                            borderRadius: isVisible
                                ? const BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  )
                                : BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Container(
                          width: MediaQuery.of(ctx).size.width,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(20),
                            ),
                          ),
                          child: GridView.builder(
                            padding: const EdgeInsets.all(8),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 5,
                                    mainAxisSpacing: 5),
                            itemCount: 7,
                            itemBuilder: (ctx, index) {
                              return InkWell(
                                onTap: () {
                                  setState(
                                    () {
                                      selectedIcon = categoriesIcons[index];
                                      isVisible = false;
                                    },
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 3,
                                      color:
                                          selectedIcon == categoriesIcons[index]
                                              ? Colors.green
                                              : Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Image.asset(
                                      'assets/${categoriesIcons[index]}.png'),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextFormField(
                        controller: categoryColorController,
                        readOnly: true,
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (ctx) {
                              return AlertDialog(
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ColorPicker(
                                      pickerColor: Colors.white,
                                      onColorChanged: (value) {
                                        setState(
                                          () {
                                            pickedColor = value;
                                          },
                                        );
                                      },
                                    ),
                                    CustomButton(
                                      onPressed: () => Navigator.of(ctx).pop(),
                                    )
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        decoration: InputDecoration(
                          fillColor: pickedColor,
                          filled: true,
                          hintText: 'Color',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      CustomButton(
                        onPressed: () {
                          setState(
                            () {
                              category.categoryId = const Uuid().v1();
                              category.name = categoryNameController.text;
                              category.icon = selectedIcon;
                              category.color = pickedColor.value;
                            },
                          );
                          context
                              .read<CreateCategoryBloc>()
                              .add(CreateCategory(category: category));
                        },
                      )
                    ],
                  ),
                ),
              ),
              backgroundColor: Colors.blueGrey[200],
            ),
          ),
        ),
      );
    },
  );
}
