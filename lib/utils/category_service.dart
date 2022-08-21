import 'package:flutter/cupertino.dart';
import '../models/category.dart';
import '../repository/database_helper.dart';

class CategoryService {
  DatabaseHelper? _db;

  CategoryService() {
    _db = DatabaseHelper();
  }

  Future<List<Category>> readCategories(String table, String order) async {
    return await _db!.getCategoryList(table, order);
  }

  Future<int> insertCategory(String table, Category category) async {
    debugPrint('Category: ${category.name}');
    debugPrint('Description: ${category.description}');
    return await _db!.insert(table, category.toMap());
  }
}
