import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_project/databse/services.dart';
import 'package:todo_project/models/todo_model.dart';

final todoRepositoryProvider = Provider<TodoRepo>((ref) => TodoRepo());

class TodoHive extends StateNotifier<List<Todo>?> {
  TodoHive(this.ref) : super(null) {
    repo = ref.read(todoRepositoryProvider);
    fetchTodo();
  }
  late TodoRepo? repo;
  final StateNotifierProviderRef ref;

  void fetchTodo() {
    state = repo!.getTodos();
  }

  void addTodo(Todo todo) {
    state = repo!.addTodo(todo);
  }

  void removeTodo(String id) {
    state = repo!.removeTodo(id);
  }

  void updateTodo(int index, Todo todo) {
    state = repo!.updateTodo(index, todo);
  }
}

final hiveData =
    StateNotifierProvider<TodoHive, List<Todo>?>((ref) => TodoHive(ref));

final getAllTodoProvider = Provider<List<Todo>>((ref) {
  final hiveDatas = ref.watch(hiveData);

  return hiveDatas ?? [];
});
