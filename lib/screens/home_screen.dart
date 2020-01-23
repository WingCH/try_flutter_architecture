// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/helper/keys.dart';
import 'package:try_flutter_architecture/helper/routes_path.dart';
import 'package:try_flutter_architecture/widgets/extra_actions_button.dart';
import 'package:try_flutter_architecture/widgets/filter_button.dart';
import 'package:try_flutter_architecture/widgets/stats_counter.dart';
import 'package:try_flutter_architecture/widgets/todo_list.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  VisibilityFilter activeFilter = VisibilityFilter.all;
  AppTab activeTab = AppTab.todos;

  void _updateVisibility(VisibilityFilter filter) {
    setState(() {
      activeFilter = filter;
    });
  }

  void _updateTab(AppTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("XXX Example"),
        actions: [
          FilterButton(
            isActive: activeTab == AppTab.todos,
            activeFilter: activeFilter,
            onSelected: _updateVisibility,
          ),
          ExtraActionsButton(
            allComplete: false,
            hasCompletedTodos: false,
            onSelected: (action) {
              print(action.toString());
            },
          )
        ],
      ),
      body: activeTab == AppTab.todos
          ? TodoList(
              filteredTodos: [
                Todo('Demo', complete: false, note: 'demo note'),
                Todo('Demo', complete: false, note: 'demo note')
              ],
            )
          : StatsCounter(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, RoutesPath.addTodo);
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        key: Keys.tabs,
        currentIndex: AppTab.values.indexOf(activeTab),
        onTap: (index) {
          _updateTab(AppTab.values[index]);
        },
        items: AppTab.values.map((tab) {
          return BottomNavigationBarItem(
            icon: Icon(
              tab == AppTab.todos ? Icons.list : Icons.show_chart,
              key: tab == AppTab.stats ? Keys.statsTab : Keys.todoTab,
            ),
            title: Text(
              tab == AppTab.stats ? "Stats" : "Todos",
            ),
          );
        }).toList(),
      ),
    );
  }
}
