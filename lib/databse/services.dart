import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_project/models/todo_model.dart';

class TodoRepo {
  late Box<Todo> _hive;
  late List<Todo> _box;
  TodoRepo();
  List<Todo> getTodos() {
    _hive = Hive.box<Todo>('todos');
    _box = _hive.values.toList();
    return _box;
  }

  List<Todo> addTodo(Todo todo) {
    _hive.add(todo);
    return _hive.values.toList();
  }

  List<Todo> removeTodo(String id) {
    _hive.deleteAt(
        _hive.values.toList().indexWhere((element) => element.id == id));
    return _hive.values.toList();
  }

  List<Todo> updateTodo(int index, Todo todo) {
    todo.isDone = !todo.isDone;
    _hive.putAt(index, todo);
    return _hive.values.toList();
  }
}
