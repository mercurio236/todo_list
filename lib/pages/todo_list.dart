import 'package:flutter/material.dart';

class TodoListPage extends StatelessWidget {
  //se precisar ter um estado na página é só transformar a extensão em Stateless
  TodoListPage({super.key});

  //cada compo de texto vai ter um controller, quando o controller é adicionado a const do super tem que ser removida
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //temos sempre que usar o Scaffold
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
          TextField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'Email', //esse aqui é o label
                hintText: '@exemplo.com', //aqui é o placeholder
                border: OutlineInputBorder()),
                onChanged: onChanged,
                onSubmitted: onSubmitted ,
          ),
          ElevatedButton(onPressed: login, child: Text('Entrar'))
        ]),
      )),
    );
  }

  void login(){
    String text = emailController.text;
    print('entrar $text');
  }

  void onChanged(String text){
    print(text);
  }

  void onSubmitted(String text){
    print('submited $text');
  }
}
