import 'package:objectbox/objectbox.dart';

@Entity()
class Todo {
  @Id()
  int taskId;
  final String taskName;
  final String? description;
  final DateTime? dueDateTime;
  final bool isCompleted;
  final bool reminder;
  final double repeat;

  Todo({
    required this.taskId,
    required this.taskName,
    this.description,
    this.dueDateTime,
    required this.isCompleted,
    required this.reminder,
    required this.repeat,
  });
}
