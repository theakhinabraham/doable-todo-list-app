import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/icon_text_box.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:doable_todo_list_app/widgets/set_reminder.dart';
import 'package:doable_todo_list_app/widgets/small_spacing.dart';
import 'package:doable_todo_list_app/widgets/text_box.dart';
import 'package:flutter_svg/svg.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  String _titleValue = '';
  String _descriptionValue = '';
  String _dateValue = '';
  String _timeValue = '';
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
              vertical: 20,
                horizontal: 15),
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
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.title_outlined),
                    hintText: "Title"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _titleValue = value;
                    });
                  },
                ),
                const SmallSpacing(),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.description_outlined),
                    hintText: "Description"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _descriptionValue = value;
                    });
                  },
                ),
                const Spacing(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Date & Time",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),

                SizedBox(height: 5,),

                TextField(
                  controller: dateController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.calendar_month_outlined),
                    hintText: "Select Date"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _dateValue = value;
                    });
                  },
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: timeController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    prefixIcon: Icon(Icons.access_time_outlined),
                    hintText: "Select Time"
                  ),
                  onChanged: (value) {
                    setState(() {
                      _timeValue = value;
                    });
                  },
                ),

                const Spacing(),

                ElevatedButton(
                  onPressed: () {}, 
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: Colors.white
                    ),
                    ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0),
                    ),
                    fixedSize: Size(200, 50),
                    shadowColor: Colors.white,
                  ),
                  ),
                //TODO: Add more TextBox() and a submit button
                //Save the data to variables
                //Save the data to ObjectBox
              ],
            )),
      ),
    );
  }
  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    timeController.dispose();
    super.dispose();
  }
}
