// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library main;

import 'dart:async';

import 'package:built_viewmodel/built_viewmodel.dart';
import 'package:flutter/material.dart';

part 'main.g.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(primarySwatch: Colors.blue),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
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

abstract class MyHomePageViewModel extends ViewModel<MyHomePageViewModelController> {
  Stream<int> get counter;

  int _count;

  @OnListenHandler('counter')
  void onListen() => print('start listening');

  @OnCancelHandler('counter')
  void onCancel() => print('cancel listening');

  void setCounter(int value) {
    _count = value;
    controller.counter.add(value);
  }

  void increaseCounter() {
    if (_count != null) setCounter(_count + 1);
  }

  factory MyHomePageViewModel() = _$MyHomePageViewModel;

  MyHomePageViewModel._();
}
