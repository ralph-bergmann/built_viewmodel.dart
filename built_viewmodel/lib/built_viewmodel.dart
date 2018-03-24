// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

abstract class ViewModel<T extends Controller> {
  T get controller;
  void dispose();
}

abstract class Controller {
  void dispose();
}

class onListenHandler {
  final String callback = 'onListen';
  final String name;
  const onListenHandler(this.name);
}

class onPauseHandler {
  final String callback = 'onPause';
  final String name;
  const onPauseHandler(this.name);
}

class onResumeHandler {
  final String callback = 'onResume';
  final String name;
  const onResumeHandler(this.name);
}

class onCancelHandler {
  final String callback = 'onCancel';
  final String name;
  const onCancelHandler(this.name);
}
