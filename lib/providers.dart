import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';

const List<ToDo> initialToDos = [
  ToDo(id: 0, description: 'タスク1', isCompleted: false),
  ToDo(id: 1, description: 'タスク2', isCompleted: false),
  ToDo(id: 2, description: 'タスク3', isCompleted: false),
  ToDo(id: 3, description: 'タスク4', isCompleted: false),
  ToDo(id: 4, description: 'タスク5', isCompleted: false),
];

class ToDoTile extends ConsumerWidget {
  const ToDoTile(this.todos, {Key? key}) : super(key: key);
  final ToDo todos;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 5),
      decoration: const BoxDecoration(color: Color(0xffeeeeee),boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0,1),blurRadius: 3)]),
      width: MediaQuery.of(context).size.width,
      key: key,

      child: GestureDetector(
        onTap: () => ref.read(todosProvider.notifier).toggle(todos.id),
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: todos.isCompleted?[
              Text(todos.description, style: const TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.lineThrough),),
              const Icon(Icons.check, color: Colors.green,),
            ]:[
              Text(todos.description, style: const TextStyle(fontSize: 15),),
            ],
          ),
        ),
      ),
    );
  }
}

class TodosNotifier extends StateNotifier<List<ToDo>> {
  TodosNotifier(): super(initialToDos);

  void addToDo(ToDo newTodo) {
    List<ToDo> newState = [];
    for (final todo in state) {
      newState.add(todo);
    }
    newState.add(newTodo);
    state = newState;
  }

  void toggle(int id) {
    List<ToDo> newState = [];
    for (final todo in state) {
      if(todo.id == id) {
        newState.add(todo.copyWith(isCompleted: !todo.isCompleted));
      } else {
        newState.add(todo);
      }
    }
    state = newState;
  }

  void removeToDo(int id) {
    List<ToDo> newState = [];
    for (final todo in state) {
      if(id != todo.id) {
        newState.add(todo);
      }
    }
    state = newState;
  }

  void editingToDo(int id, String description) {
    List<ToDo> newState = [];
    for (final todo in state) {
      if(description == '') {
        return;
      }
      if(todo.id == id) {
        newState.add(todo.copyWith(description: description));
      } else {
        newState.add(todo);
      }
    }
    state = newState;
  }

}

final todosProvider = StateNotifierProvider<TodosNotifier, List<ToDo>>((ref) {
  return TodosNotifier();
});



