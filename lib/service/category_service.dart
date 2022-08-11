import 'package:flutter/cupertino.dart';

import '../models/category.dart';

class CategoryService {
  saveCategory(Category category) {
    debugPrint('Category: ${category.name}');
    debugPrint('Description: ${category.description}');
  }
}
