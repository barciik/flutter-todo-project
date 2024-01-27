import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/screens/todos.dart';

class StartScreen extends ConsumerWidget {
  StartScreen({super.key});

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Todo App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(children: [
        const SizedBox(
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 5),
          child: TextField(
            maxLength: 15,
            controller: _nameController,
            decoration: const InputDecoration(
              label: Text("Enter your name"),
            ),
          ),
        ),
        const SizedBox(
          height: 50,
        ),
        ElevatedButton(
            onPressed: () async {
              if (_nameController.text.trim() == '') {
                return;
              }
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              prefs.setString('name', _nameController.text);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (ctx) =>
                      TodosScreen(titleName: _nameController.text)));
            },
            child: const Text('Start')),
      ]),
    );
  }
}
