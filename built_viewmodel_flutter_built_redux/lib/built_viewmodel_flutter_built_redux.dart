// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_viewmodel/built_viewmodel.dart';
import 'package:flutter/widgets.dart' hide Builder;
import 'package:flutter_built_redux/flutter_built_redux.dart';
import 'package:meta/meta.dart';

abstract class ViewModelFlutterBuiltReduxMixin<State extends Built<State, StateBuilder>,
    StateBuilder extends Builder<State, StateBuilder>, Actions extends ReduxActions> extends ViewModelBaseMixin {
  Store<State, StateBuilder, Actions> store;
  Actions actions;

  void onStateChanged(StoreChange<State, StateBuilder, dynamic> stateChange);

  @override
  @mustCallSuper
  void build(BuildContext context) {
    _listen(context);
  }

  void _listen(BuildContext context) {
    store = _store(context);
    actions = store?.actions;
    store?.stream?.listen((StoreChange<State, StateBuilder, dynamic> stateChange) => onStateChanged(stateChange));
  }

  Store<State, StateBuilder, Actions> _store(BuildContext context) {
    final ReduxProvider reduxProvider = context.inheritFromWidgetOfExactType(ReduxProvider);
    assert(reduxProvider != null, 'Store not found, did you forgot ReduxProvider?');
    return reduxProvider.store as Store<State, StateBuilder, Actions>;
  }
}
