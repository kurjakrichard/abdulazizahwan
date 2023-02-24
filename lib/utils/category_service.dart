import 'package:flutter/cupertino.dart';
import '../models/category.dart';
import '../repository/database_handler.dart';

class CategoryService {
  DatabaseHandler? _db;

  CategoryService() {
    _db = DatabaseHandler();
  }

  //Read data from table
  Future<List<Map<String, dynamic>>> readData() async {
    return await _db!.getData('Categories', 'name');
  }

  //Read categories as a list
  Future<List<Category>> readCategories(String table, String order) async {
    return await _db!.getCategoryList(table, order);
  }

  //Update category
  Future<int> readCategoriesById(String table, Category category) async {
    return await _db!.update(table, category.id);
  }

  //Insert new category
  Future<int> addCategory(String table, Category category) async {
    debugPrint('Category: ${category.name}');
    debugPrint('Description: ${category.description}');
    return await _db!.insert(table, category.toMap());
  }
}
