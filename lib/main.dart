import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/reducers/app_state_reducer.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';
import 'package:try_flutter_architecture/screens/home_screen.dart';

import 'helper/routes_path.dart';
import 'helper/theme.dart';

void main() {
  final store = Store<AppState>(appReducer,
      initialState: AppState.loading(), middleware: []);
  runApp(TodoApp(store: store,));
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
            );
          },
          RoutesPath.addTodo: (context) {
            return AddEditScreen();
          },
        },
        initialRoute: RoutesPath.home,
      ),
    );
  }
}
