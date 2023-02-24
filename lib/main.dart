import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const TodoListApp());
}

class TodoListApp extends StatelessWidget {
  const TodoListApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todolist Sqflite',
        home: HomeScreen());
  }
}
