// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:built_redux/generator.dart';
import 'package:built_value_generator/built_value_generator.dart';
import 'package:built_viewmodel_generator/built_viewmodel_generator.dart';
import 'package:source_gen/source_gen.dart';

final builders = [
  applyToRoot(
    new PartBuilder([
      new BuiltViewModelGenerator(),
      new BuiltValueGenerator(),
      new BuiltReduxGenerator(),
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
