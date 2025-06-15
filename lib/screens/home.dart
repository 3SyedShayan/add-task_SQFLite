import 'package:add_task/services/database_service.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final DatabaseService _databaseService = DatabaseService.instance;
  // Using the singleton instance of DatabaseService

  String? _tasks = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: _addTaskButton());
  }

  Widget _addTaskButton() {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (_) => AlertDialog(
                title: const Text('Add Task'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          _tasks =
                              value; // Update the state with the input value
                        });
                        // Handle text input changes
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter task content',
                      ),
                    ),
                    MaterialButton(
                      child: const Text('Add Task'),
                      onPressed: () {
                        if (_tasks == null || _tasks == "") return;
                        _databaseService.addTask(_tasks!);
                        setState(() {
                          _tasks = null;
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ),
        );
      },
      child: const Icon(Icons.add),
    );
  }
}
