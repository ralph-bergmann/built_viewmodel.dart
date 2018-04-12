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

class ViewModelConnector<T extends ViewModel<Controller>> extends StatelessWidget {
  const ViewModelConnector({@required this.viewModel, this.onInit, this.onDispose, @required this.builder})
      : assert(viewModel != null),
        assert(builder != null);

  final T viewModel;
  final _OnInitCallback<T> onInit;
  final _OnDisposeCallback<T> onDispose;
  final _ViewModelBuilder<T> builder;

  Widget build(BuildContext context) {
    viewModel.build(context);
    return new _LifecycleListener(
      viewModel: viewModel,
      onInit: onInit,
      onDispose: onDispose,
      builder: builder,
    );
  }
}

class _LifecycleListener<T extends ViewModel<Controller>> extends StatefulWidget {
  _LifecycleListener({@required this.viewModel, this.onInit, this.onDispose, @required this.builder})
      : assert(viewModel != null),
        assert(builder != null);

  final T viewModel;
  final _OnInitCallback<T> onInit;
  final _OnDisposeCallback<T> onDispose;
  final _ViewModelBuilder<T> builder;

  @override
  State<StatefulWidget> createState() {
    return new _LifecycleListenerState<T>();
  }

  void _onInit() {
    if (onInit != null) onInit(viewModel);
  }

  Widget _onBuild(BuildContext context) {
    return builder(viewModel);
  }

  void _onDispose() {
    if (onDispose != null) onDispose(viewModel);
    viewModel.dispose();
  }
}

class _LifecycleListenerState<T extends ViewModel<Controller>> extends State<_LifecycleListener<T>> {
  @override
  void initState() {
    super.initState();
    widget._onInit();
  }

  @override
  Widget build(BuildContext context) => widget._onBuild(context);

  @override
  void dispose() {
    widget._onDispose();
    super.dispose();
  }
}

typedef void _OnInitCallback<T>(T viewModel);
typedef void _OnDisposeCallback<T>(T viewModel);
typedef Widget _ViewModelBuilder<T>(T viewModel);
