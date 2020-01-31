// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';

//因為第一下係AppState.loading(), 之後TodosLoadedAction / TodosNotLoadedAction
final loadingReducer = combineReducers<bool>([
  TypedReducer<bool, LoadTodosAction>(_setLoaded),
]);

bool _setLoaded(bool state, action) {
  return false;
}
