// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

library test;

import 'dart:async';

import 'package:built_viewmodel/built_viewmodel.dart';

part 'test.g.dart';

abstract class Test implements ViewModel<TestController> {
  @onListenHandler('messages')
  onListen() {
    print('onListen :-)');
  }

  @onCancelHandler('messages')
  bar() {}

  @onCancelHandler('messages2')
  foo() {}

  Stream<String> get messages;

  Stream<int> get messages2;

  void test(String msg, int num) {
    controller.messages.add(msg);
    controller.messages2.add(num);
  }

  factory Test() = _$Test;

  Test._();
}

class TestTest {
  Test model;

  TestTest() {
    model = new Test();
  }

  void testTest(String msg, int num) {
    model.test(msg, num);
  }
}

Future main(List<String> args) async {
  final testTest = new TestTest();
  testTest.model.messages.listen((msg) => print(msg));
  testTest.model.messages2.listen((num) => print(num));
  testTest.model.test('hallo welt 1', 1);
  testTest.model.test('hallo welt 2', 2);
  testTest.model.test('hallo welt 3', 3);
}
