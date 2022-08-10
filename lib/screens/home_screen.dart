import 'dart:io';
import 'package:flutter/material.dart';

import 'categories_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todolist Sqflite'),
      ),
      drawer: drawerWidget(),
      body: Container(),
    );
  }

  Widget drawerWidget() {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text('Kurják Richárd'),
            accountEmail: const Text('kurjak.richard@gmail.com'),
            currentAccountPicture: CircleAvatar(
                backgroundImage: Image.file(File(
                        '/home/sire/Képek/Képek magamról/KurjákRichárdCV.jpg'))
                    .image),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const HomeScreen();
              }));
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: const Text('Categories'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return const CategoriesScreen();
              }));
            },
          )
        ],
      ),
    );
  }
}
