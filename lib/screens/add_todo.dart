import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_project/models/todo_model.dart';
import 'package:todo_project/providers/todo_provider.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _AddTodoState();
  }
}

class _AddTodoState extends ConsumerState<AddTodoScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void addTodo() {
    ref.read(hiveData.notifier).addTodo(Todo(
        description: _descriptionController.text,
        name: _titleController.text,
        createdAt: DateTime.now(),
        isDone: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add new ToDo',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(children: [
            TextField(
              controller: _titleController,
              maxLength: 25,
              decoration: const InputDecoration(label: Text('Title')),
            ),
            TextField(
              controller: _descriptionController,
              maxLength: 50,
              decoration: const InputDecoration(label: Text('Description')),
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_titleController.text.trim() == '') {
                        showDialog(
                            context: context,
                            builder: (ctx) =>  AlertDialog(
                                  title: const Text('Invalid value'),
                                  content: const Text(
                                      'Please make sure to provide a title'),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'))
                                  ],
                                ));
                        return;
                      } else {
                        addTodo();
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Text('Add')),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel')),
              ],
            )
          ]),
        ));
  }
}
