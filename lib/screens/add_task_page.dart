import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/icon_text_box.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:doable_todo_list_app/widgets/set_reminder.dart';
import 'package:doable_todo_list_app/widgets/small_spacing.dart';
import 'package:doable_todo_list_app/widgets/text_box.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding(context),
                vertical: verticalPadding(context)),
            child: Column(
              children: [
                Row(
                  children: [
                    const BackArrow(),
                    Text(
                      "Create to-do",
                      style: Theme.of(context).textTheme.displayLarge,
                    )
                  ],
                ),
                const Spacing(),
                const SetReminder(),
                const Spacing(),
                //Todo title & Todo description
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tell us about your task",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SmallSpacing(),
                TextBox(hintHeading: "Title", controller: titleController),
                const SmallSpacing(),
                TextBox(
                    hintHeading: "Description",
                    controller: descriptionController),
                const Spacing(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date & Time",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                IconTextBox(
                    hintHeading: "Set Date",
                    controller: dateController,
                    iconLocation: 'assets/calendar.svg'),
                IconTextBox(
                    hintHeading: "Set Time",
                    controller: timeController,
                    iconLocation: 'assets/clock.svg'),
                //TODO: Add more TextBox() and a submit button
                //Save the data to variables
                //Save the data to ObjectBox
              ],
            )),
      ),
    );
  }
}
