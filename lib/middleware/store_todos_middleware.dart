import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/selectors/selectors.dart';

List<Middleware<AppState>> createStoreTodosMiddleware(
//    TodosRepository repository,
    ) {
//  final saveTodos = _createSaveTodos(repository);
//  final loadTodos = _createLoadTodos(repository);

  final saveTodos = _createSaveTodos();
  final loadTodos = _createLoadTodos();

  return [
    TypedMiddleware<AppState, LoadTodosAction>(loadTodos),
    TypedMiddleware<AppState, AddTodoAction>(saveTodos),
    TypedMiddleware<AppState, ClearCompletedAction>(saveTodos),
    TypedMiddleware<AppState, ToggleAllAction>(saveTodos),
    TypedMiddleware<AppState, UpdateTodoAction>(saveTodos),
    TypedMiddleware<AppState, TodosLoadedAction>(saveTodos),
    TypedMiddleware<AppState, DeleteTodoAction>(saveTodos),
  ];
}

//Middleware<AppState> _createSaveTodos(TodosRepository repository) {
Middleware<AppState> _createSaveTodos() {
  return (Store<AppState> store, action, NextDispatcher next) {
    next(action);


//      todosSelector(store.state).map((todo) => todo.toEntity()).toList(),

  };
}

//Middleware<AppState> _createLoadTodos(TodosRepository repository) {
Middleware<AppState> _createLoadTodos() {
  return (Store<AppState> store, action, NextDispatcher next) {
//    repository.loadTodos().then(
//          (todos) {
        store.dispatch(
          TodosLoadedAction(
            []
          ),
        );
//      },
//    ).catchError((_) => store.dispatch(TodosNotLoadedAction()));

    next(action);
  };
}