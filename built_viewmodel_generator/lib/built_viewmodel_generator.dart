// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:built_viewmodel_generator/src/viewmodel_source_class.dart';
import 'package:source_gen/source_gen.dart';

class BuiltViewModelGenerator extends Generator {
  const BuiltViewModelGenerator();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) {
    final result = new StringBuffer();

    for (final element in library.allElements) {
      if (element is ClassElement && ViewModelSourceClass.isSourceFile(element)) {
        try {
          result.writeln(new ViewModelSourceClass(element).generateCode() ?? '');
        } catch (e, st) {
          log.severe('Error in BuiltViewModelGenerator for $element.', e, st);
        }
      }
    }

    if (result.isNotEmpty) {
      return result.toString();
    } else {
      return null;
    }
  }
}
