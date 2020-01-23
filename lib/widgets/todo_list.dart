// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/helper/keys.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/screens/detail_screen.dart';
import 'package:try_flutter_architecture/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> filteredTodos;

  TodoList({
    this.filteredTodos = const [],
  }) : super(key: Keys.todoList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: filteredTodos.isEmpty
          ? Center(child: Text('Empty'))
          : ListView.builder(
              key: Keys.todoList,
              itemCount: filteredTodos.length,
              itemBuilder: (BuildContext context, int index) {
                final todo = filteredTodos[index];
                return TodoItem(
                  todo: todo,
                  onDismissed: (direction) {
                    _removeTodo(context, todo);
                  },
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) {
                          return DetailScreen(
                            todo: todo,
                          );
                        },
                      ),
                    );
                  },
                  onCheckboxChanged: (complete) {
                    print("onCheckboxChanged");
                  },
                );
              },
            ),
    );
  }

  void _removeTodo(BuildContext context, Todo todo) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        key: Keys.snackbar,
        duration: Duration(seconds: 2),
        content: Text(
          'Deleted' + todo.task,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {},
        ),
      ),
    );
  }
}
