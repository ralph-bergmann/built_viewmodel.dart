// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:built_viewmodel/built_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:meta/meta.dart';
import 'package:redux/redux.dart';

abstract class ViewModelFlutterReduxMixin<S, R> extends ViewModelBaseMixin {
  Store<S> store;

  R convert(S state);

  void onStateChanged(R state);

  @override
  @mustCallSuper
  void build(BuildContext context) {
    store = _store(context);
    _listen(context);
  }

  void _listen(BuildContext context) {
    store?.onChange?.listen((S state) {
      _onStateChanged(state);
    });
  }

  Store<S> _store(BuildContext context) => StoreProvider.of<S>(context);

  void _onStateChanged(S state) => onStateChanged(convert(state));
}
