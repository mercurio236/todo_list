import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  //se precisar ter um estado na página é só transformar a extensão em Stateless
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();

  List<Todo> todos = [];

  void addTodo() {
    String text = todoController.text;
    setState(() {
      Todo newTodo = Todo(title: text, date: DateTime.now());
      todos.add(newTodo);
    });
    todoController.clear();
  }

  void onDelete(Todo todo) {
    setState(() {
      todos.remove(todo);
    });
  }

  void onDeleAll(){
    setState(() {
      todos.clear();
    });
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
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTodo,
                  child: Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00d7f3),
                      padding: const EdgeInsets.all(17),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Flexible(
              // faz com que ocupe o máximo de tamanho
              child: ListView(
                shrinkWrap: true, //vai fazer o calculo do tamanho da tela
                children: [
                  for (Todo todo in todos)
                    TodoListItem(todo: todo, onDelete: onDelete)
                ],
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              children: [
                Expanded(
                    child:
                        Text('Você possui ${todos.length} tarefas pendentes')),
                const SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  onPressed: onDeleAll,
                  child: Text(
                    'Limpar tudo',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff00d7f3),
                      padding: const EdgeInsets.all(17),
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
