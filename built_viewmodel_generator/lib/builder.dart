// Copyright (c) 2018., Ralph Bergmann.
// All rights reserved. Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:build/build.dart';
import 'package:built_viewmodel_generator/built_viewmodel_generator.dart';
import 'package:source_gen/source_gen.dart';

Builder builtViewModel(BuilderOptions options) => new PartBuilder([const BuiltViewModelGenerator()]);
