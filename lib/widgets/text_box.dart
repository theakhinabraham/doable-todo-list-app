import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  final String hintHeading;

  const TextBox({super.key, required this.hintHeading, required controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:
          Theme.of(context).textTheme.displaySmall!.copyWith(color: blackColor),
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(100.0),
      borderSide: BorderSide(width: 1.0, color: outlineColor)),
        focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(100.0),
    borderSide: BorderSide(width: 1.0, color: blueColor)),
        hintText: hintHeading,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        contentPadding: textFieldPadding(context),
      ),
    );
  }
}
