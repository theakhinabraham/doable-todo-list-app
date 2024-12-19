import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/screens/settings_page.dart';
import 'package:doable_todo_list_app/widgets/add_task_button.dart';
import 'package:doable_todo_list_app/widgets/header.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:doable_todo_list_app/widgets/today_and_filter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: SvgPicture.asset(
                        "assets/trans_logo.svg",
                      ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
              icon: Icon(Icons.settings_outlined),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
              },
            ),
          ),
        ],

      ),
        floatingActionButton: const AddTaskButton(),
        body: SafeArea(
          child: Padding(
            //SafeArea
            padding: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              children: [
                ListView(
                  
                ),
                const TodayAndFilterButton(),
                //Filter todo tasks
                //File location: widgets/todayAndFilterButton.dart
                const Spacing(),
                //TODO: Add List of all tasks in the mobile device
                //If tasks are empty, show text
              ],
            ),
          ),
        ));
  }
}
