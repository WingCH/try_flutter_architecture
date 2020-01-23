// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/helper/keys.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';

class DetailScreen extends StatelessWidget {
  final Todo todo;

  DetailScreen({
    @required this.todo,
  }) : super(key: Keys.todoDetailsScreen);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo Details"),
        actions: [
          IconButton(
            key: Keys.deleteTodoButton,
            tooltip: "Delete Todo",
            icon: Icon(Icons.delete),
            onPressed: () {
              Navigator.pop(context, todo);
            },
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Checkbox(
                    value: todo.complete,
                    key: Keys.detailsTodoItemCheckbox,
                    onChanged: (complete) {},
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: 8.0,
                          bottom: 16.0,
                        ),
                        child: Text(
                          todo.task,
                          key: Keys.detailsTodoItemTask,
                          style: Theme.of(context).textTheme.headline,
                        ),
                      ),
                      Text(
                        todo.note,
                        key: Keys.detailsTodoItemNote,
                        style: Theme.of(context).textTheme.subhead,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Edit Todo",
        child: Icon(Icons.edit),
        key: Keys.editTodoFab,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddEditScreen(
                  key: Keys.editTodoScreen,
                  todo: todo,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
