// GENERATED CODE - DO NOT MODIFY BY HAND

part of main;

// **************************************************************************
// Generator: BuiltViewModelGenerator
// **************************************************************************

class _$MyHomePageViewModel extends MyHomePageViewModel {
  factory _$MyHomePageViewModel() => new _$MyHomePageViewModel._();

  _$MyHomePageViewModel._() : super._();

  MyHomePageViewModelController _controller;

  Stream<int> _counter;

  @override
  Stream<int> get counter =>
      _counter ??= controller.counter.stream.asBroadcastStream();
  MyHomePageViewModelController get controller => _controller ??=
      new _$MyHomePageViewModelController().._messagesOnListen = onListen;
  @override
  void dispose() {
    controller.dispose();
  }
}

abstract class MyHomePageViewModelController implements Controller {
  StreamController<int> get counter;
}

class _$MyHomePageViewModelController extends MyHomePageViewModelController {
  Function _messagesOnListen;

  StreamController<int> _counter;

  StreamController<int> get counter => _counter ??= new StreamController<int>();
  @override
  void dispose() {
    _counter.close();
  }
}