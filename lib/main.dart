import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/middleware/store_todos_middleware.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/reducers/app_state_reducer.dart';
import 'package:try_flutter_architecture/repositorys/firebase_user_repository.dart';
import 'package:try_flutter_architecture/repositorys/firestore_reactive_todos_repository.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';
import 'package:try_flutter_architecture/screens/home_screen.dart';

import 'containers/add_todo.dart';
import 'helper/routes_path.dart';
import 'helper/theme.dart';

void main() {
  //https://stackoverflow.com/questions/57689492/flutter-unhandled-exception-servicesbinding-defaultbinarymessenger-was-accesse
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  final Store<AppState> store;

  //initializer variable(store) in constructor
  //https://stackoverflow.com/questions/50274605/colon-after-constructor-in-dart
  TodoApp({
    Key key,
    FirestoreReactiveTodosRepository todosRepository,
    FirebaseUserRepository userRepository,
  })  : store = Store<AppState>(
          appReducer,
          initialState: AppState.loading(),
          middleware: createStoreTodosMiddleware(
              todosRepository: todosRepository ??
                  FirestoreReactiveTodosRepository(Firestore.instance),
              userRepository: userRepository ??
                  FirebaseUserRepository(FirebaseAuth.instance)),
        ),
        super(key: key) {
    store.dispatch(InitAppAction());
  }

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        onGenerateTitle: (context) => "Basic UI",
        theme: GenericTheme.theme,
        routes: {
          RoutesPath.home: (context) {
            return HomeScreen();
          },
          RoutesPath.addTodo: (context) {
            return AddTodo();
          },
        },
        initialRoute: RoutesPath.home,
      ),
    );
  }
}
