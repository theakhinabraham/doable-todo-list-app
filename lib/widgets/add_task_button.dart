import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AddTaskButton extends StatelessWidget {
  const AddTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, 'add_task');
      },
      backgroundColor: blackColor,
      elevation: 0,
      splashColor: blueColor,
      shape: const CircleBorder(),
      child: SvgPicture.asset(
        "assets/plus.svg",
        height: MediaQuery.of(context).size.height * 0.02,
      ),
    );
  }
}
