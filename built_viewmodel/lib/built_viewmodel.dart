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

class OnListenHandler {
  final String callback = 'onListen';
  final String name;
  const OnListenHandler(this.name);
}

class OnPauseHandler {
  final String callback = 'onPause';
  final String name;
  const OnPauseHandler(this.name);
}

class OnResumeHandler {
  final String callback = 'onResume';
  final String name;
  const OnResumeHandler(this.name);
}

class OnCancelHandler {
  final String callback = 'onCancel';
  final String name;
  const OnCancelHandler(this.name);
}
