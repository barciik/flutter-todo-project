import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_project/models/todo_model.dart';
import 'package:todo_project/screens/start.dart';
import 'package:todo_project/screens/todos.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final name = prefs.containsKey('name') ? prefs.get('name').toString() : null;
  runApp(ProviderScope(
      child: MyApp(
    name: name,
  )));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key, required this.name});
  final String? name;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget screen = name != null
        ? TodosScreen(
            titleName: name!,
          )
        : StartScreen();

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: screen,
    );
  }
}
