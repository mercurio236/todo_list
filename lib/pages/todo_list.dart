import 'package:flutter/material.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  //se precisar ter um estado na página é só transformar a extensão em Stateless
  TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<String> todos = [];

  void addTodo() {
    String text = todoController.text;
    setState(() {
      todos.add(text);
    });
    todoController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Adicione uma tarefa',
                        hintText: 'Ex. Estudar Flutter'),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTodo,
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00d7f3),
                      padding: EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Flexible(
              // faz com que ocupe o máximo de tamanho
              child: ListView(
                shrinkWrap: true, //vai fazer o calculo do tamanho da tela
                children: [
                  for (String todo in todos) TodoListItem(title: todo)
                ],
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child:
                        Text('Você possui ${todos.length} tarefas pendentes')),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Limpar tudo',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00d7f3),
                      padding: EdgeInsets.all(22),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                )
              ],
            )
          ],
        ),
      )),
    ));
  }
}
