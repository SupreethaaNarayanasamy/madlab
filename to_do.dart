import 'package:flutter/material.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: TodoScreen());
  }
}

class TodoScreen extends StatefulWidget {
  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  List<String> tasks = [];
  final TextEditingController _controller = TextEditingController();

  void _addOrUpdateTask({int? index}) {
    if (_controller.text.isNotEmpty) {
      setState(() {
        if (index == null) {
          tasks.add(_controller.text); // Add new task
        } else {
          tasks[index] = _controller.text; // Update task
        }
      });
      _controller.clear();
    }
  }

  void _deleteTask(int index) {
    setState(() => tasks.removeAt(index));
  }

  void _showTaskDialog({int? index}) {
    if (index != null) _controller.text = tasks[index]; // Pre-fill for update
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(index == null ? "Add Task" : "Edit Task"),
        content: TextField(controller: _controller),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              _addOrUpdateTask(index: index);
              Navigator.pop(context);
            },
            child: Text(index == null ? "Add" : "Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To-Do List")),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(tasks[index]),
          onTap: () => _showTaskDialog(index: index), // Tap to edit
          trailing: IconButton(
            icon: Icon(Icons.delete, color: Colors.red),
            onPressed: () => _deleteTask(index),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTaskDialog(),
        child: Icon(Icons.add),
      ),
    );
  }
}
