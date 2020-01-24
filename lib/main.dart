import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/models/todo.dart';
import 'package:try_flutter_architecture/reducers/app_state_reducer.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';
import 'package:try_flutter_architecture/screens/home_screen.dart';

import 'containers/add_todo.dart';
import 'helper/routes_path.dart';
import 'helper/theme.dart';

void main() {
  final store = Store<AppState>(
    appReducer,
    initialState: AppState.loading(),
    middleware: [],
  );
  runApp(TodoApp(
    store: store,
  ));
}

class TodoApp extends StatelessWidget {
  final Store<AppState> store;

  const TodoApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        onGenerateTitle: (context) => "Basic UI",
        theme: GenericTheme.theme,
        routes: {
          RoutesPath.home: (context) {
            return HomeScreen(
              onInit: () {
                //Load empty data
                StoreProvider.of<AppState>(context).dispatch(
                  TodosLoadedAction(
                      [
                        Todo("demo 1"),
                        Todo("demo 2", complete: true),
                        Todo("demo 3"),
                        Todo("demo 4", note: "notes here"),
                        Todo("demo 5"),
                      ]
                  ),
                );
              },
            );
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
