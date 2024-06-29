import 'package:doable_todo_list_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SetReminder extends StatelessWidget {

  const SetReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () {
                      //TODO: Toggle Notification reminder
                    },
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.all(0))),
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.45,
                      padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.065,
                      ),
                      decoration: BoxDecoration(
                          color: blackColor,
                          borderRadius: BorderRadius.circular(
                              MediaQuery.of(context).size.width)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Set Reminder",
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(color: whiteColor, fontSize: 13),
                          ),
                          SvgPicture.asset("assets/bell_white.svg",
                              height: MediaQuery.of(context).size.height *
                                  0.014),
                        ],
                      ),
                    ),
                  ),
                );
  }
}