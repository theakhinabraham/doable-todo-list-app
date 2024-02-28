import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/add_task_button.dart';
import 'package:doable_todo_list_app/widgets/header.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:doable_todo_list_app/widgets/today_and_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doable_todo_list_app/todos_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
        floatingActionButton: const AddTaskButton(),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding(context),
              vertical: verticalPadding(context),
            ),
            child: const Column(
              children: [
                Header(),
                Spacing(),
                TodayAndFilterButton(),
                //Filter todo tasks
                //File location: widgets/todayAndFilterButton.dart
                Spacing(),
                //TODO: Add List of all tasks in the mobile device
                //If tasks are empty, show text
              ],
            ),
          ),
        ));
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