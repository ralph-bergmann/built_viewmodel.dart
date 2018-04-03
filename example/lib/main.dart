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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final MyHomePageViewModel model = new MyHomePageViewModel();
  final String title;

  @override
  _MyHomePageState createState() {
    model.setCounter(0);
    return new _MyHomePageState();
  }
}

abstract class MyHomePageViewModel implements ViewModel<MyHomePageViewModelController> {
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

  factory MyHomePageViewModel() = _$MyHomePageViewModel;

  MyHomePageViewModel._();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text('You have pushed the button this many times:'),
            new StreamBuilder(
              stream: widget.model.counter,
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
      floatingActionButton: new StreamBuilder(
          stream: widget.model.counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            return new FloatingActionButton(
              onPressed: () => widget.model.setCounter(snapshot.data + 1),
              tooltip: 'Increment',
              child: new Icon(Icons.add),
            );
          }),
    );
  }

  @override
  void dispose() {
    widget.model.dispose();
    super.dispose();
  }
}
