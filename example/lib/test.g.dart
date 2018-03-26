// GENERATED CODE - DO NOT MODIFY BY HAND

part of test;

// **************************************************************************
// Generator: BuiltViewModelGenerator
// **************************************************************************

class _$Test extends Test {
  factory _$Test() => new _$Test._();

  _$Test._() : super._();

  TestController __controller;

  @override
  Stream<String> get messages => controller.messages.stream;
  @override
  Stream<int> get messages2 => controller.messages2.stream;
  TestController get controller => __controller ??= new _$TestController()
    ..messages_onListen = onListen()
    ..messages_onCancel = bar()
    ..messages2_onCancel = foo();
  @override
  void dispose() {
    controller.dispose();
  }
}

abstract class TestController implements Controller {
  StreamController<String> get messages;

  StreamController<int> get messages2;
}

class _$TestController extends TestController {
  Function messages_onListen;

  Function messages_onCancel;

  Function messages2_onCancel;

  StreamController<String> __messages;

  StreamController<int> __messages2;

  StreamController<String> get messages =>
      __messages ??= new StreamController<String>(
          onListen: messages_onListen, onCancel: messages_onCancel);
  StreamController<int> get messages2 =>
      __messages2 ??= new StreamController<int>(onCancel: messages2_onCancel);
  @override
  void dispose() {
    messages.close();
    messages2.close();
  }
}
