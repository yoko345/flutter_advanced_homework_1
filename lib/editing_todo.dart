import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'models.dart';
import 'providers.dart';

final idNameProvider = StateProvider<int>((ref) => 10);

class EditingToDo extends ConsumerWidget {
  const EditingToDo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final List<ToDo> todoList = ref.watch(todosProvider);
    TextEditingController descriptionEditingController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('ToDoリスト', style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.check),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, _) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xffeeeeee),boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0,1),blurRadius: 3)]),
                  child: GestureDetector(
                    onTap: () => showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('タスクの編集'),
                          content: TextField(
                            keyboardType: TextInputType.text,
                            controller: descriptionEditingController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () {
                                if(descriptionEditingController.text == '') {
                                  return Navigator.pop(context, 'Cancel');
                                }
                                ref.read(todosProvider.notifier).addToDo(
                                    ToDo(
                                      id: ref.read(idNameProvider.notifier).state++,
                                      description: descriptionEditingController.text,
                                      isCompleted: false,
                                    )
                                );
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.add),
                      title: Text('タスクを追加', style: TextStyle(fontSize: 15),),
                    ),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    children: todoList.map((todo) =>
                        Container(
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          decoration: const BoxDecoration(color: Color(0xffeeeeee),boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0,1),blurRadius: 3)]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width/3*2,
                                child: GestureDetector(
                                  onTap: () => showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      descriptionEditingController.text = todo.description;
                                      return AlertDialog(
                                        title: const Text('タスクの編集'),
                                        content: TextField(
                                          keyboardType: TextInputType.text,
                                          controller: descriptionEditingController,
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                            child: const Text('キャンセル'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref.read(todosProvider.notifier).editingToDo(todo.id, descriptionEditingController.text);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  child: Text(todo.description, style: todo.isCompleted?const TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.lineThrough):const TextStyle(fontSize: 15),),
                                ),
                              ),
                              GestureDetector(
                                  onTap: ()=> showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        content: const Text('リストから消去しますか？'),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () => Navigator.pop(context, 'Cancel'),
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              ref.read(todosProvider.notifier).removeToDo(todo.id);
                                              Navigator.pop(context, 'OK');
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                  child: const Icon(Icons.close, color: Colors.red,)
                              ),
                            ],
                          ),
                        )
                    ).toList(),
                  ),
                );
              },
            ),
            Consumer(
              builder: (context, ref, _) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  decoration: const BoxDecoration(color: Color(0xffeeeeee),boxShadow: [BoxShadow(color: Colors.black, offset: Offset(0,1),blurRadius: 3)]),
                  child: GestureDetector(
                    onTap: ()=> showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('タスクの編集'),
                          content: TextField(
                            keyboardType: TextInputType.text,
                            controller: descriptionEditingController,
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.pop(context, 'Cancel'),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () {
                                if(descriptionEditingController.text == '') {
                                  return Navigator.pop(context, 'Cancel');
                                }
                                ref.read(todosProvider.notifier).addToDo(
                                    ToDo(
                                      id: ref.read(idNameProvider.notifier).state++,
                                      description: descriptionEditingController.text,
                                      isCompleted: false,
                                    )
                                );
                                Navigator.pop(context, 'OK');
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.add),
                      title: Text('タスクを追加', style: TextStyle(fontSize: 15),),
                    ),
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
