// Copyright (c) 2018, Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library main;

import 'dart:async';

import 'package:built_viewmodel/built_viewmodel.dart';

part 'main.g.dart';

main(List<String> arguments) {
  final model = new MyHomePageViewModel();
  model.counter.listen((int value) => print('got $value'));

  model.setCounter(0);
  model.setCounter(1);
  model.setCounter(2);
  model.setCounter(3);
}

abstract class MyHomePageViewModel implements ViewModel<MyHomePageViewModelController> {
  Stream<int> get counter;

  @OnListenHandler('counter')
  onListen() => print('someone is listening');

  void setCounter(int value) => controller.counter.add(value);

  factory MyHomePageViewModel() = _$MyHomePageViewModel;

  MyHomePageViewModel._();
}
