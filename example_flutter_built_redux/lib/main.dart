// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library main;

import 'dart:async';

import 'package:built_redux/built_redux.dart';
import 'package:built_value/built_value.dart';
import 'package:built_viewmodel/built_viewmodel.dart';
import 'package:built_viewmodel_flutter_built_redux/built_viewmodel.dart';
import 'package:flutter/material.dart' hide Builder;
import 'package:flutter_built_redux/flutter_built_redux.dart';

part 'main.g.dart';

void main() => runApp(new MyApp());

class IncrementAction {}

abstract class AppState implements Built<AppState, AppStateBuilder> {
  factory AppState() => new _$AppState._(count: 0);

  AppState._();

  int get count;
}

abstract class AppActions extends ReduxActions {
  factory AppActions() => new _$AppActions();

  AppActions._();

  ActionDispatcher<Null> get increment;
}

ReducerBuilder<AppState, AppStateBuilder> reducerBuilder = new ReducerBuilder<AppState, AppStateBuilder>()
  ..add(AppActionsNames.increment, (s, a, b) => b.count++);

class MyApp extends StatelessWidget {
  final Store<AppState, AppStateBuilder, AppActions> store = new Store<AppState, AppStateBuilder, AppActions>(
    reducerBuilder.build(),
    new AppState(),
    new AppActions(),
  );

  Widget build(BuildContext context) => ReduxProvider(
        store: store,
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          home: new MyHomePage(title: 'Flutter Demo Home Page'),
        ),
      );
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final MyHomePageViewModel model = new MyHomePageViewModel();
  final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(title),
      ),
      body: new ViewModelConnector(
        viewModel: model,
        onInit: (MyHomePageViewModel viewModel) => viewModel.setCounter(0),
        builder: (MyHomePageViewModel viewModel) => new Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Text('You have pushed the button this many times:'),
                  new StreamBuilder(
                    stream: viewModel.counter,
                    builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                      if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return new Text('not connected');
                        case ConnectionState.waiting:
                          return new Text('awaiting interaction...');
                        case ConnectionState.active:
                          return new Text('counter: ${snapshot.data}');
                        case ConnectionState.done:
                          return new Text('counter: ${snapshot.data} (closed)');
                        default:
                          throw "Unknown: ${snapshot.connectionState}";
                      }
                    },
                  ),
                ],
              ),
            ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: () => model.increaseCounter(),
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
    );
  }
}

abstract class MyHomePageViewModel extends ViewModel<MyHomePageViewModelController>
    with ViewModelFlutterBuiltReduxMixin<AppState, AppStateBuilder, AppActions, int> {
  Stream<int> get counter;

  @OnListenHandler('counter')
  void onListen() => print('start listening');

  @OnPauseHandler('counter')
  void onPause() => print('pause listening');

  @OnResumeHandler('counter')
  void onResume() => print('resume listening');

  @OnCancelHandler('counter')
  void onCancel() => print('cancel listening');

  void setCounter(int value) => controller.counter.add(value);

  void increaseCounter() => actions?.increment();

  int convert(AppState state) => state.count;

  void onStateChanged(int state) => setCounter(state);

  factory MyHomePageViewModel() = _$MyHomePageViewModel;

  MyHomePageViewModel._();
}
