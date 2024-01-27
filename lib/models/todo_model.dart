import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:hive/hive.dart';

part 'todo.g.dart';


final formatter = DateFormat.yMd().add_jm();
const uuid = Uuid();

@HiveType(typeId: 0)
class Todo extends HiveObject{
  Todo({
    required this.description,
    required this.name,
    required this.createdAt,
    this.isDone = false,
  }) : id = uuid.v4();

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime createdAt;

  @HiveField(4)
  bool isDone;

  String get formattedDate {
    return formatter.format(createdAt);
  }
}
