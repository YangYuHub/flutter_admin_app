import 'package:redux/redux.dart';

/**
 * 变灰Redux
 * Created by robert
 * Date: 2022-04-11
 */

final GreyReducer = combineReducers<bool>([
  TypedReducer<bool, RefreshGreyAction>(_refresh),
]);

bool _refresh(bool grey, RefreshGreyAction action) {
  return action.grey;
}

class RefreshGreyAction {
  final bool grey;

  RefreshGreyAction(this.grey);
}
