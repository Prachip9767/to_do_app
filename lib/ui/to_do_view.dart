import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/ui/to_do_controller.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    Provider.of<TodoProvider>(context, listen: false).fetData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('To Do App'),
      ),
      body: Consumer<TodoProvider>(
        builder: (BuildContext context, TodoProvider value, Widget? child) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final todo = value.data[index];
                    return ListTile(
                      title: Text(todo.title,
                          maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          value.deleteItem(todo.id);
                        },
                      ),
                      leading: todo.isCompleted
                          ? const Icon(Icons.done)
                          : const SizedBox.shrink(),
                    );
                  },
                  itemCount: value.data.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter todo title',
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () async {
                        final title = _controller.text.trim();
                        if (title.isNotEmpty) {
                          try {
                            await value.addItem(title);
                            _controller.clear();
                          } catch (e) {
                            if (kDebugMode) {
                              print('Error adding todo: $e');
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}



