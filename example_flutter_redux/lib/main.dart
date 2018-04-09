// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library main;

import 'dart:async';

import 'package:built_viewmodel/built_viewmodel.dart';
import 'package:built_viewmodel_flutter_redux/built_viewmodel_flutter_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

part 'main.g.dart';

void main() => runApp(new MyApp());

class IncrementAction {}

class AppState {
  final int count;

  AppState(this.count);

  factory AppState.initial() => AppState(0);
}

AppState appReducer(AppState state, dynamic action) => AppState(counterReducer(state.count, action));

final Reducer<int> counterReducer = combineReducers([
  TypedReducer<int, IncrementAction>(_increment),
]);

int _increment(int count, IncrementAction action) => count + 1;

class MyApp extends StatelessWidget {
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
  );

  Widget build(BuildContext context) => StoreProvider(
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
    with ViewModelFlutterReduxMixin<AppState, int> {
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

  void increaseCounter() => store?.dispatch(new IncrementAction());

  int convert(AppState state) => state.count;

  void onStateChanged(int state) => setCounter(state);

  factory MyHomePageViewModel() = _$MyHomePageViewModel;

  MyHomePageViewModel._();
}
