// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:try_flutter_architecture/containers/active_tab.dart';
import 'package:try_flutter_architecture/containers/extra_actions_container.dart';
import 'package:try_flutter_architecture/containers/filter_selector.dart';
import 'package:try_flutter_architecture/containers/filtered_todos.dart';
import 'package:try_flutter_architecture/containers/stats.dart';
import 'package:try_flutter_architecture/containers/tab_selector.dart';
import 'package:try_flutter_architecture/helper/keys.dart';
import 'package:try_flutter_architecture/helper/routes_path.dart';
import 'package:try_flutter_architecture/models/app_tab.dart';

class HomeScreen extends StatefulWidget {
  final void Function() onInit;

  HomeScreen({@required this.onInit}) : super(key: Keys.homeScreen);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    widget.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ActiveTab(
      builder: (BuildContext context, AppTab activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Redux demo"),
            actions: [
              FilterSelector(visible: activeTab == AppTab.todos),
              ExtraActionsContainer(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            key: Keys.addTodoFab,
            onPressed: () {
              Navigator.pushNamed(context, RoutesPath.addTodo);
            },
            child: Icon(Icons.add),
            tooltip: "addTodo",
          ),
          bottomNavigationBar: TabSelector(),
        );
      },
    );
  }
}
