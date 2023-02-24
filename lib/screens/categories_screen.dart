import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/category_service.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  TextEditingController _categoryController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  Category _category = Category('', '');
  final CategoryService _categoryService = CategoryService();
  List<Category>? _categoryList;

  @override
  void initState() {
    super.initState();
    getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: ListView.builder(
          itemCount: _categoryList?.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(
                      onPressed: () async {
                        _showFormDialog(
                            context, 'Edit category', _categoryList![index].id);
                      },
                      icon: const Icon(Icons.edit)),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList?.length != null
                          ? _categoryList![index].name
                          : ''),
                      IconButton(
                          icon: const Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {})
                    ],
                  ),
                  subtitle: Text(_categoryList?.length != null
                      ? _categoryList![index].description
                      : ''),
                ),
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          _showFormDialog(context, 'New category', _category);
          getCategories();
        },
      ),
    );
  }

  void getCategories() async {
    _categoryList = await _categoryService.readCategories('categories', 'name');

    setState(() {
      _categoryList;
    });
  }

  // ignore: unused_element
  Future<void> _editCategories(
      BuildContext context, String table, Category category) async {
    await _categoryService.readCategoriesById(table, category);
    setState(() {});
  }

  Future _showFormDialog(
      BuildContext context, String title, Category category) {
    return showDialog(
        context: context,
        builder: (value) {
          return AlertDialog(
            actions: [
              TextButton(
                onPressed: () async {
                  category.name = _categoryController.text;
                  category.description = _descriptionController.text;
                  if (_category.name != '') {
                    // ignore: unused_local_variable
                    int result = await _categoryService.addCategory(
                        'categories', _category);
                    setState(() {
                      getCategories();
                    });
                    _categoryController = TextEditingController();
                    _descriptionController = TextEditingController();
                    _category = Category('', '');
                  }

                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (state) => Colors.blue)),
                child:
                    const Text('Save', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith(
                        (state) => Colors.red)),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _categoryController,
                    decoration: const InputDecoration(
                        hintText: 'Write a category', labelText: 'Category'),
                  ),
                  TextField(
                    controller: _descriptionController,
                    decoration: const InputDecoration(
                        hintText: 'Write a description',
                        labelText: 'Description'),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
