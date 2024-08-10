class CategoryEntity {
  String categoryId;
  String name;
  String icon;
  int color;
  int totalExpense;

  CategoryEntity({
    required this.categoryId,
    required this.name,
    required this.icon,
    required this.color,
    required this.totalExpense,
  });


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'categoryId': categoryId,
      'name': name,
      'icon': icon,
      'color': color,
      'totalExpense': totalExpense,
    };
  }

  static CategoryEntity fromMap(Map<String, dynamic> map) {
    return CategoryEntity(
      categoryId: map['categoryId'] as String,
      name: map['name'] as String,
      icon: map['icon'] as String,
      color: map['color'] as int,
      totalExpense: map['totalExpense'] as int,
    );
  }
}
