// GENERATED CODE - DO NOT MODIFY BY HAND

part of main;

// **************************************************************************
// Generator: BuiltViewModelGenerator
// **************************************************************************

class _$MyHomePageViewModel extends MyHomePageViewModel {
  factory _$MyHomePageViewModel() => new _$MyHomePageViewModel._();

  _$MyHomePageViewModel._() : super._();

  Stream<int> _counter;

  MyHomePageViewModelController _controller;

  @override
  Stream<int> get counter =>
      _counter ??= controller.counter.stream.asBroadcastStream();
  MyHomePageViewModelController get controller => _controller ??=
      new _$MyHomePageViewModelController().._counterOnListen = onListen;
  @override
  void dispose() {
    controller.dispose();
  }
}

abstract class MyHomePageViewModelController implements Controller {
  StreamController<int> get counter;
}

class _$MyHomePageViewModelController extends MyHomePageViewModelController {
  ControllerCallback _counterOnListen;

  StreamController<int> _counter;

  StreamController<int> get counter =>
      _counter ??= new StreamController<int>(onListen: _counterOnListen);
  @override
  void dispose() {
    _counter.close();
  }
}
