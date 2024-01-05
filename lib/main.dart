import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove o banner de debbug
      home: TodoListPage(),
    ); // o MaterialApp é uma função muito importante, aqui contem tudo
  }

}
