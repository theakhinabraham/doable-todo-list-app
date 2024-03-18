import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/add_task_button.dart';
import 'package:doable_todo_list_app/widgets/header.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:doable_todo_list_app/widgets/today_and_filter_button.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        floatingActionButton: const AddTaskButton(),
        body: SafeArea(
          child: Padding(
            //SafeArea
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