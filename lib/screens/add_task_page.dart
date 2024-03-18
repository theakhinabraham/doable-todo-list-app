import 'package:doable_todo_list_app/main.dart';
import 'package:doable_todo_list_app/widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:doable_todo_list_app/todos_notifier.dart';
import 'package:doable_todo_list_app/widgets/back_arrow.dart';
import 'package:doable_todo_list_app/widgets/set_reminder.dart';
import 'package:doable_todo_list_app/widgets/small_spacing.dart';
import 'package:doable_todo_list_app/widgets/text_box.dart';

class AddTaskPage extends ConsumerWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final todos = ref.watch(todosProvider);

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
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Tell us about your task",
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ),
                const SmallSpacing(),
                const TextBox(hintHeading: "Title"),
              ],
            )),
      ),
    );
  }
}

/*
final todos = watch(todosProvider); // Listen for changes
final todosNotifier = context.read(todosProvider.notifier); // Access notifier

final newTodo = Todo(taskName: 'New Task', ...);
// Set other properties based on UI input
todosNotifier.addTodo(newTodo);


final todoToEdit = todos.firstWhere((todo) => todo.taskId == editedTodoId);
todoToEdit.taskName = 'Updated Task Name';
// Update other properties as needed
todosNotifier.updateTodo(todoToEdit);


final todoToDelete = todos.firstWhere((todo) => todo.taskId == deletedTodoId);
todosNotifier.deleteTodo(todoToDelete);
*/