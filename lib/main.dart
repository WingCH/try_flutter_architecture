import 'package:flutter/material.dart';
import 'package:try_flutter_architecture/screens/add_edit_screen.dart';
import 'package:try_flutter_architecture/screens/home_screen.dart';

import 'helper/routes_path.dart';
import 'helper/theme.dart';

void main() => runApp(TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (context) => "Basic UI",
      theme: GenericTheme.theme,
      routes: {
        RoutesPath.home: (context) {
          return HomeScreen();
        },
        RoutesPath.addTodo: (context) {
          return AddEditScreen();
        },
      },
      initialRoute: RoutesPath.home,
    );
  }
}
