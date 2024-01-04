import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  //se precisar ter um estado na página é só transformar a extensão em Stateless
  const TodoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Adicione uma tarefa',
                    hintText: 'Ex. Estudar Flutter'),
              ),
            ),
            SizedBox(width: 8),
            ElevatedButton(
              onPressed: () {},
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
      )),
    );
  }
}
