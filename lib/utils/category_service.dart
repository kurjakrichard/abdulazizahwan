import 'package:flutter/cupertino.dart';
import '../models/category.dart';
import '../repository/database_helper.dart';

class CategoryService {
  DatabaseHelper? _db;

  CategoryService() {
    _db = DatabaseHelper();
  }

  Future<int> saveCategory(Category category) async {
    debugPrint('Category: ${category.name}');
    debugPrint('Description: ${category.description}');
    return await _db!.insertCategory(category);
  }
}
