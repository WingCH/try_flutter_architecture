import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/helper/keys.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';

class EditTodo extends StatelessWidget {
  final Todo todo;

  EditTodo({this.todo, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, OnSaveCallback>(
      converter: (Store<AppState> store) {
        return (task, note) {
          store.dispatch(UpdateTodoAction(
            todo.id,
            todo.copyWith(
              task: task,
              note: note,
            ),
          ));
        };
      },
      builder: (BuildContext context, OnSaveCallback onSave) {
        return AddEditScreen(
          key: Keys.editTodoScreen,
          onSave: onSave,
          isEditing: true,
          todo: todo,
        );
      },
    );
  }
}