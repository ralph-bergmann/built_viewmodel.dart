# built_viewmodel.dart

The `built_viewmodel.dart` package provides a way to create `ViewModel` classes. 
It is a little bit inspired by the [Android ViewModel](https://developer.android.com/topic/libraries/architecture/viewmodel.html) but just a little bit ;-)

Usually, you call `setState()` whenever the state of the Widget should change. 
But in my opinion, it is not a good idea to call `setState()` when just a small part of the whole state has changed
(read more: [How fast is Flutter? I built a stopwatch app to find out.](https://medium.freecodecamp.org/how-fast-is-flutter-i-built-a-stopwatch-app-to-find-out),
[Avoiding Empty State Callbacks](https://medium.com/@mehmetf_71205/setting-the-state)).

This package creates lots of streams (as much as you need) to feed StreamBuilders.


## Let's start

Create an abstract class, e.g. `MyHomePageViewModel`:


```dart
library main;

import 'dart:async';

import 'package:built_viewmodel/built_viewmodel.dart';

part 'main.g.dart';

abstract class MyHomePageViewModel implements ViewModel<MyHomePageViewModelController> {


  factory MyHomePageViewModel() = _$MyHomePageViewModel;
  MyHomePageViewModel._();
}
```

And add a reference of it to the Widget:

```dart
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
```


For now, the ViewModel makes nothing. You have to add your needed stream(s):

```dart
abstract class MyHomePageViewModel implements ViewModel<MyHomePageViewModelController> {

  Stream<int> get counter;   // new

  factory MyHomePageViewModel() = _$MyHomePageViewModel;
  MyHomePageViewModel._();
```

You also need to add a code generator. Create a `tool/build.dart` file with the following content:

```dart
import 'dart:async';

import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:built_viewmodel_generator/built_viewmodel_generator.dart';
import 'package:source_gen/source_gen.dart';

final builders = [
  applyToRoot(
    new PartBuilder([
      new BuiltViewModelGenerator(),
    ]),
    generateFor: const InputSet(
      include: const [
        'lib/*.dart',
      ],
    ),
  ),
];

Future main(List<String> args) async {
  await build(
    builders,
    deleteFilesByDefault: true,
    verbose: false,
  );
}
```

Execute the `tool/build.dart` file and it will generate a `main.g.dart` file which has all the logic for your stream(s). 

### Use the stream

To use the stream(s) you need a [StreamBuilder](https://docs.flutter.io/flutter/widgets/StreamBuilder-class.html) 
where you have to set the stream to the one from the ViewModel:

```dart
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
```

Whenever you send a new value to the stream the content of the StreamBuilder will change 
but only this small part and not the whole state.

To do that add a `void setCounter(int value)` method to the ViewModel ...

```dart
abstract class MyHomePageViewModel implements ViewModel<MyHomePageViewModelController> {
  Stream<int> get counter;

  void setCounter(int value) => controller.counter.add(value);   // new

  factory MyHomePageViewModel() = _$MyHomePageViewModel;
  MyHomePageViewModel._();
}
```

... and just call it.

You can find the [full example here](https://github.com/the4thfloor/built_viewmodel.dart/blob/master/example/lib/main.dart).
