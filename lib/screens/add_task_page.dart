import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doable_todo_list_app/todos_notifier.dart';

class AddTaskPage extends ConsumerWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return const Scaffold();
  }
}
