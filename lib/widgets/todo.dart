import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_project/models/todo_model.dart';
import 'package:todo_project/providers/todo_provider.dart';

class TodoItem extends ConsumerWidget {
  const TodoItem({super.key, required this.todo, required this.index});

  final Todo todo;
  final int index;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final test = todo.isDone;
    // final isCompleted = ref.watch(todoProvider.select((value) => todo)).isDone;
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todo.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: 6,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 210,
                  child: Text(
                    todo.description,
                    softWrap: true,
                    //50 characters
                    maxLines: 2,
                  ),
                ),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        ref.read(hiveData.notifier).updateTodo(index, todo);
                      },
                      child: Icon(
                        test ? Icons.check_box : Icons.check_box_outline_blank,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          ref.read(hiveData.notifier).removeTodo(todo.id);
                        },
                        child: const Icon(Icons.remove)),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 6,
            ),
            Text(todo.formattedDate),
          ],
        ),
      ),
    );
  }
}
