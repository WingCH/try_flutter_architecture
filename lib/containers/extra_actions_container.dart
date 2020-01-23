import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:try_flutter_architecture/actions/actions.dart';
import 'package:try_flutter_architecture/models/app_state.dart';
import 'package:try_flutter_architecture/models/extra_action.dart';
import 'package:try_flutter_architecture/selectors/selectors.dart';
import 'package:try_flutter_architecture/widgets/extra_actions_button.dart';

class ExtraActionsContainer extends StatelessWidget {
  ExtraActionsContainer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      distinct: true,
      converter: _ViewModel.fromStore,
      builder: (context, vm) {
        return ExtraActionsButton(
          allComplete: vm.allComplete,
          onSelected: vm.onActionSelected,
        );
      },
    );
  }
}

class _ViewModel {
  final Function(ExtraAction) onActionSelected;
  final bool allComplete;

  _ViewModel({
    @required this.onActionSelected,
    @required this.allComplete,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      onActionSelected: (action) {
        if (action == ExtraAction.clearCompleted) {
          store.dispatch(ClearCompletedAction());
        } else if (action == ExtraAction.toggleAllComplete) {
          store.dispatch(ToggleAllAction());
        }
      },
      allComplete: allCompleteSelector(todosSelector(store.state)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is _ViewModel &&
              runtimeType == other.runtimeType &&
              allComplete == other.allComplete;

  @override
  int get hashCode => allComplete.hashCode;
}