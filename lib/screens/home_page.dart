import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:doable_todo_list_app/todos_notifier.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding(context),
            vertical: verticalPadding(context)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  "assets/trans_logo.svg",
                  height: MediaQuery.of(context).size.height / 20,
                ),
                SvgPicture.asset(
                  "assets/hamburger.svg",
                  height: MediaQuery.of(context).size.height / 35,
                ),
              ],
            ),
            Spacing(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                TextButton(
                  onPressed: () {
                    //TODO: Filter todo tasks
                  },
                  style: TextButton.styleFrom(padding: const EdgeInsets.all(0)),
                  child: Container(
                  height: MediaQuery.of(context).size.height / 15,
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        width: 2.0, color: outlineColor),
                        borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width)
                  ),
                  child: Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Filter",
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                          SvgPicture.asset("assets/filter.svg"),
                        ],
                      ),
                    ),
                  ),
                ),
                ),
              ],
            ),
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