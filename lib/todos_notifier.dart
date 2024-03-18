import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:doable_todo_list_app/db/models.dart';
import 'package:doable_todo_list_app/objectbox.g.dart';

final storeProvider = Provider((ref) async {
  final docsDir = await getApplicationDocumentsDirectory();
  final store = await openStore(
    directory: p.join(docsDir.path, "obx-example"),
    model: getObjectBoxModel(),
  );
  return store;
});

final todosBox = FutureProvider<Box<Todo>>((ref) async {
  final store = await ref.watch(storeProvider);
  return store.box<Todo>();
});

final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>(
  (ref) {
    final box = ref.watch(todosBox);
    return TodosNotifier([], box as Box<Todo>);
  },
);

class TodosNotifier extends StateNotifier<List<Todo>> {
  late final Box<Todo> todosBox;

  TodosNotifier(super.initialTodos, this.todosBox);

  void addTodo(Todo todo) {
    todosBox.put(todo);
    state = [...state, todo];
  }

  void updateTodo(Todo updatedTodo) {
    todosBox.put(updatedTodo);
    state = [
      for (final todo in state)
        if (todo.taskId == updatedTodo.taskId) updatedTodo else todo
    ];
  }

  void deleteTodo(Todo todo) {
    todosBox.remove(todo.taskId);
    state = state.where((t) => t.taskId != todo.taskId).toList();
  }

  List<Todo> searchTodos(String query) {
    return state
        .where(
            (todo) => todo.taskName.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  List<Todo> filterTodos(bool isCompleted) {
    return state.where((todo) => todo.isCompleted == isCompleted).toList();
  }
}
