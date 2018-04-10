// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

abstract class ViewModelBaseMixin {
  void build(BuildContext context) {}
}

abstract class ViewModel<T extends Controller> extends ViewModelBaseMixin {
  T get controller;
  void dispose();
}

abstract class Controller {
  void dispose();
}

class OnListenHandler {
  final String name;
  const OnListenHandler(this.name);
}

@deprecated
class OnPauseHandler {
  final String name;
  const OnPauseHandler(this.name);
}

@deprecated
class OnResumeHandler {
  final String name;
  const OnResumeHandler(this.name);
}

class OnCancelHandler {
  final String name;
  const OnCancelHandler(this.name);
}

class ViewModelConnector<T extends ViewModel<Controller>> extends _ViewModelConnectorBase<T> {
  const ViewModelConnector({@required this.viewModel, this.onInit, this.onDispose, @required this.builder})
      : assert(viewModel != null),
        assert(builder != null);

  final T viewModel;
  final _OnInitCallback<T> onInit;
  final _OnDisposeCallback<T> onDispose;
  final _ViewModelBuilder<T> builder;

  void init() {
    if (onInit != null) onInit(viewModel);
  }

  @override
  Widget build(BuildContext context) {
    viewModel.build(context);
    return builder(viewModel);
  }

  void dispose() {
    if (onDispose != null) onDispose(viewModel);
    viewModel.dispose();
  }
}

abstract class _ViewModelConnectorBase<T extends ViewModel<Controller>> extends StatefulWidget {
  const _ViewModelConnectorBase({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _ViewModelConnectorBaseState<T>();

  void init();

  Widget build(BuildContext context);

  void dispose();
}

class _ViewModelConnectorBaseState<T extends ViewModel<Controller>> extends State<_ViewModelConnectorBase<T>> {
  @override
  void initState() {
    super.initState();
    widget.init();
  }

  @override
  Widget build(BuildContext context) => widget.build(context);

  @override
  void dispose() {
    widget.dispose();
    super.dispose();
  }
}

typedef void _OnInitCallback<T>(T viewModel);
typedef void _OnDisposeCallback<T>(T viewModel);
typedef Widget _ViewModelBuilder<T>(T viewModel);
