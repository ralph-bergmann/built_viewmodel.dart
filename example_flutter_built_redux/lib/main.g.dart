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
  Stream<int> get counter => _counter ??= controller.counter.stream;
  MyHomePageViewModelController get controller =>
      _controller ??= new _$MyHomePageViewModelController()
        .._counterOnListen = onListen
        .._counterOnCancel = onCancel;
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

  ControllerCancelCallback _counterOnCancel;

  StreamController<int> _counter;

  StreamController<int> get counter =>
      _counter ??= new StreamController<int>.broadcast(
          onListen: _counterOnListen, onCancel: _counterOnCancel);
  @override
  void dispose() {
    _counter?.close();
  }
}

// **************************************************************************
// Generator: BuiltValueGenerator
// **************************************************************************

// ignore_for_file: always_put_control_body_on_new_line
// ignore_for_file: annotate_overrides
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_returning_this
// ignore_for_file: omit_local_variable_types
// ignore_for_file: prefer_expression_function_bodies
// ignore_for_file: sort_constructors_first

class _$AppState extends AppState {
  @override
  final int count;

  factory _$AppState([void updates(AppStateBuilder b)]) =>
      (new AppStateBuilder()..update(updates)).build();

  _$AppState._({this.count}) : super._() {
    if (count == null) throw new BuiltValueNullFieldError('AppState', 'count');
  }

  @override
  AppState rebuild(void updates(AppStateBuilder b)) =>
      (toBuilder()..update(updates)).build();

  @override
  AppStateBuilder toBuilder() => new AppStateBuilder()..replace(this);

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! AppState) return false;
    return count == other.count;
  }

  @override
  int get hashCode {
    return $jf($jc(0, count.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('AppState')..add('count', count))
        .toString();
  }
}

class AppStateBuilder implements Builder<AppState, AppStateBuilder> {
  _$AppState _$v;

  int _count;
  int get count => _$this._count;
  set count(int count) => _$this._count = count;

  AppStateBuilder();

  AppStateBuilder get _$this {
    if (_$v != null) {
      _count = _$v.count;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AppState other) {
    if (other == null) throw new ArgumentError.notNull('other');
    _$v = other as _$AppState;
  }

  @override
  void update(void updates(AppStateBuilder b)) {
    if (updates != null) updates(this);
  }

  @override
  _$AppState build() {
    final _$result = _$v ?? new _$AppState._(count: count);
    replace(_$result);
    return _$result;
  }
}

// **************************************************************************
// Generator: BuiltReduxGenerator
// **************************************************************************

class _$AppActions extends AppActions {
  factory _$AppActions() => new _$AppActions._();
  _$AppActions._() : super._();

  final ActionDispatcher<Null> increment =
      new ActionDispatcher<Null>('AppActions-increment');

  @override
  void setDispatcher(Dispatcher dispatcher) {
    increment.setDispatcher(dispatcher);
  }
}

class AppActionsNames {
  static final ActionName<Null> increment =
      new ActionName<Null>('AppActions-increment');
}
