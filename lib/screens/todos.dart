import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:todo_project/providers/todo_provider.dart';
import 'package:todo_project/screens/add_todo.dart';
import 'package:todo_project/widgets/todo.dart';

class TodosScreen extends ConsumerStatefulWidget {
  const TodosScreen({super.key, required this.titleName});

  final String titleName;

  @override
  ConsumerState<TodosScreen> createState() {
    return _TodosScreenState();
  }
}

class _TodosScreenState extends ConsumerState<TodosScreen> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final fetchTodo = ref.watch(getAllTodoProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const AddTodoScreen()));
            },
            icon: const Icon(
              Icons.add_box,
              size: 35,
              color: Colors.white,
            ),
          )
        ],
        title: Text(
          'Welcome ${widget.titleName}',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(4),
        children: [
          ...fetchTodo
              .map((todo) => TodoItem(
                    index: fetchTodo.indexOf(todo),
                    todo: todo,
                  ))
              .toList()
        ],
      ),
    );
  }
}
