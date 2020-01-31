// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/selectors/selectors.dart';

final todosReducer = combineReducers<List<Todo>>([
  TypedReducer<List<Todo>, LoadTodosAction>(_setLoadedTodos),
  TypedReducer<List<Todo>, DeleteTodoAction>(_deleteTodo),

]);
//TODO: 自己寫好d Reducer
List<Todo> _setLoadedTodos(List<Todo> todos, LoadTodosAction action) {
  return action.todos;
}

List<Todo> _deleteTodo(List<Todo> todos, DeleteTodoAction action) {
  return todos..removeWhere((todo) => todo.id == action.id);
}