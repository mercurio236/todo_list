import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repository.dart';
import 'package:todo_list/widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  //se precisar ter um estado na página é só transformar a extensão em Stateless
  const TodoListPage({super.key});

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final TextEditingController todoController = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  List<Todo> todos = [];

  Todo? deletedTodo;
  int? deletedTodoPos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  String addTodo() {
    String text = todoController.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Row(children: [
          Icon(
            Icons.warning,
            color: Colors.white,
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Text(
              'Preencha o campo com uma tarefa',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ]),
        backgroundColor: Color.fromARGB(255, 224, 195, 5),
        action: SnackBarAction(
          label: 'Fechar',
          onPressed: () {},
          textColor: Colors.white,
        ),
      ));
      return '';
    }

    setState(() {
      Todo newTodo = Todo(title: text, date: DateTime.now());
      todos.add(newTodo);
    });
    todoController.clear();
    todoRepository.saveTodoList(todos);
    return '';
  }

  void onDelete(Todo todo) {
    deletedTodo = todo; //tarefa removida
    deletedTodoPos = todos.indexOf(todo); // posição na lista

    setState(() {
      todos.remove(todo);
    });

    todoRepository.saveTodoList(todos);

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(width: 5),
          Expanded(
              child: Text(
            'Tarefa ${todo.title} foi removida com sucesso.',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ))
        ],
      ),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: 'Desfazer',
        onPressed: () {
          setState(() {
            todos.insert(deletedTodoPos!, deletedTodo!);
          });
          todoRepository.saveTodoList(todos);
        },
        textColor: Colors.white,
      ),
      duration: const Duration(seconds: 5),
    ));
  }

  void onDeleAll() {
    setState(() {
      todos.clear();
    });
    todoRepository.saveTodoList(todos);
    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(child: Text('Suas tarefas forma deletadas com sucesso!'))
        ],
      ),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 5),
    ));
  }

  void showDeleteTodosConfirmationdialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Lipar tudo?'),
        content: Text('Todas as tarefas serão apagadas'),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar')),
          TextButton(
            onPressed: onDeleAll,
            child: Text(
              'Limpar tudo',
              style: TextStyle(color: Colors.white),
            ),
            style: TextButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(3)),
            ),
          ),
        ],
      ),
    );
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
                //shrinkWrap: true, //vai fazer o calculo do tamanho da tela
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
                  onPressed: showDeleteTodosConfirmationdialog,
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
