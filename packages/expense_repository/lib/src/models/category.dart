import '../entities/entities.dart';

class Category {
  String categoryId;
  String name;
  String icon;
  int color;
  int totalExpense;

  Category({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
    required this.totalExpense,
  });

  static final empty = Category(
    categoryId: '',
    name: '',
    icon: '',
    color: 0,
    totalExpense: 0,
  );

  CategoryEntity toEntity() {
    return CategoryEntity(
      categoryId: categoryId,
      name: name,
      icon: icon,
      color: color,
      totalExpense: totalExpense,
    );
  }

  static Category fromEntity(CategoryEntity entity) {
    return Category(
      categoryId: entity.categoryId,
      name: entity.name,
      icon: entity.icon,
      color: entity.color,
      totalExpense: entity.totalExpense,
    );
  }
}
