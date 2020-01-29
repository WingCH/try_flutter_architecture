import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/repositorys/firebase_user_repository.dart';
import 'package:try_flutter_architecture/repositorys/firestore_reactive_todos_repository.dart';
import 'package:try_flutter_architecture/selectors/selectors.dart';

List<Middleware<AppState>> createStoreTodosMiddleware(
    {FirestoreReactiveTodosRepository todosRepository,
    FirebaseUserRepository userRepository}) {
  return [
    TypedMiddleware<AppState, InitAppAction>(
      _firestoreSignIn(userRepository),
    ),
    TypedMiddleware<AppState, ConnectToDataSourceAction>(
      _firestoreConnect(todosRepository),
    ),
    TypedMiddleware<AppState, AddTodoAction>(
      _firestoreSaveNewTodo(todosRepository),
    ),
    TypedMiddleware<AppState, DeleteTodoAction>(
      _firestoreDeleteTodo(todosRepository),
    ),
    TypedMiddleware<AppState, UpdateTodoAction>(
      _firestoreUpdateTodo(todosRepository),
    ),
    TypedMiddleware<AppState, ToggleAllAction>(
      _firestoreToggleAll(todosRepository),
    ),
    TypedMiddleware<AppState, ClearCompletedAction>(
      _firestoreClearCompleted(todosRepository),
    ),
  ];
}

// https://stackoverflow.com/questions/55423660/what-does-void-function-do-in-dart
// see TypedMiddleware, A [Middleware] function that only works on actions of a specific type.
void Function(
  Store<AppState> store,
  InitAppAction action,
  NextDispatcher next,
) _firestoreSignIn(
  FirebaseUserRepository repository,
) {
  return (store, action, next) {
    next(action);

    repository.login().then((_) {
      store.dispatch(ConnectToDataSourceAction());
    });
  };
}

void Function(
  Store<AppState> store,
  ConnectToDataSourceAction action,
  NextDispatcher next,
) _firestoreConnect(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);

    repository.todos().listen((todos) {
      print(todos);
      store.dispatch(LoadTodosAction(todos.map(Todo.fromEntity).toList()));
    });
  };
}

void Function(
  Store<AppState> store,
  AddTodoAction action,
  NextDispatcher next,
) _firestoreSaveNewTodo(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.addNewTodo(action.todo.toEntity());
  };
}

void Function(
  Store<AppState> store,
  DeleteTodoAction action,
  NextDispatcher next,
) _firestoreDeleteTodo(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.deleteTodo([action.id]);
  };
}

void Function(
  Store<AppState> store,
  UpdateTodoAction action,
  NextDispatcher next,
) _firestoreUpdateTodo(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);
    repository.updateTodo(action.updatedTodo.toEntity());
  };
}

void Function(
  Store<AppState> store,
  ToggleAllAction action,
  NextDispatcher next,
) _firestoreToggleAll(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);
    var todos = todosSelector(store.state);

    for (var todo in todos) {
      if (allCompleteSelector(todos)) {
        if (todo.complete) {
          repository.updateTodo(todo.copyWith(complete: false).toEntity());
        }
      } else {
        if (!todo.complete) {
          repository.updateTodo(todo.copyWith(complete: true).toEntity());
        }
      }
    }
  };
}

void Function(
  Store<AppState> store,
  ClearCompletedAction action,
  NextDispatcher next,
) _firestoreClearCompleted(
  FirestoreReactiveTodosRepository repository,
) {
  return (store, action, next) {
    next(action);

    repository.deleteTodo(
      completeTodosSelector(todosSelector(store.state))
          .map((todo) => todo.id)
          .toList(),
    );
  };
}
