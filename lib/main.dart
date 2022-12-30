import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'providers.dart';
import 'editing_todo.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDoリスト',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef  ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ToDoリスト', style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context){return EditingToDo();})),
            child: const Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                final List<ToDo> todoList = ref.watch(todosProvider);
                return SizedBox(
                  height: MediaQuery.of(context).size.width,
                  child: ReorderableListView.builder(
                    itemBuilder: (_, index) => ToDoTile(
                      todoList[index],
                      key: Key('$index'),
                    ),
                    itemCount: todoList.length,
                    onReorder: (int oldIndex, int newIndex) {
                      if(oldIndex < newIndex) {
                        newIndex -= 1;
                      }
                      todoList.insert(newIndex, todoList.removeAt(oldIndex));
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
