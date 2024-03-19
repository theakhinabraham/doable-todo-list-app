import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconTextBox extends StatefulWidget {
  final String hintHeading;
  final String iconLocation;
  final TextEditingController controller;

  const IconTextBox(
      {super.key,
      required this.hintHeading,
      required this.controller,
      required this.iconLocation});

  @override
  State<IconTextBox> createState() => _IconTextBoxState();
}

class _IconTextBoxState extends State<IconTextBox> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style:
          Theme.of(context).textTheme.displaySmall!.copyWith(color: blackColor),
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(widget.iconLocation),
        suffixIcon: widget.controller.text.isEmpty
            ? null
            : SvgPicture.asset('assets/cross.svg'),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(width: 1.0, color: outlineColor)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100.0),
            borderSide: BorderSide(width: 1.0, color: blueColor)),
        hintText: widget.hintHeading,
        hintStyle: Theme.of(context).textTheme.displaySmall,
        contentPadding: textFieldPadding(context),
      ),
      controller: widget.controller,
      onChanged: (text) => setState(() {}),
    );
  }
}
