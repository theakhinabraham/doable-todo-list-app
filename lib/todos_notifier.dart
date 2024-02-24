import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodosModel {
  final String title;
  final String? description;
  final int? date;
  final int? time;
  final bool? notify;
  final bool? status;
  final String? repeat;

  TodosModel({
    required this.title,
    this.description,
    this.date,
    this.time,
    this.notify,
    this.status,
    this.repeat,
  });

  TodosModel copyWith({
    String? title,
    String? description,
    int? date,
    int? time,
    bool? notify,
    bool? status,
    String? repeat,
  }) {
    return TodosModel(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      time: time ?? this.time,
      notify: notify ?? this.notify,
      status: status ?? this.status,
      repeat: repeat ?? this.repeat,
    );
  }
}

class TodosState {
  final List<TodosModel> todos;

  const TodosState({
    required this.todos,
  });

  TodosState copyWith({
    List<TodosModel>? todos,
  }) {
    return TodosState(
      todos: todos ?? this.todos,
    );
  }
}

class TodosNotifier extends StateNotifier<TodosState> {
  TodosNotifier() : super(const TodosState(todos: []));
  //TODO: add functions: add, remove, edit, toggle

  void addTodo(TodosModel todo) {
    state = state.copyWith(todos: [...state.todos, todo]);
  }
}
