import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doable_todo_list_app/todos_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return const Scaffold();
  }
}

/* 
onPressed:(){
  ref.read(todosProvider.notifier).addTodo(
    TodosModel(
      title: "donate books",
      description: "gather books I dont read",
      date: 120023,
      time: 2043,
      notify: true,
      status: true,
      repeat: "daily",
    ),
  );
*/