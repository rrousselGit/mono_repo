// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:args/args.dart';
import 'package:args/command_runner.dart';

import 'commands/check.dart';
import 'commands/mono_repo_command.dart';
import 'commands/presubmit.dart';
import 'commands/pub.dart';
import 'commands/travis.dart';
import 'version.dart';

final List<Command<Null>> commands = List<Command<Null>>.unmodifiable(
    [CheckCommand(), PresubmitCommand(), PubCommand(), TravisCommand()]);

class MonoRepoRunner extends CommandRunner<Null> {
  MonoRepoRunner()
      : super(
            'mono_repo', 'Manage multiple packages in one source repository.') {
    commands.forEach(addCommand);
    argParser.addFlag('version',
        negatable: false, help: 'Prints the version of mono_repo.');
    argParser.addFlag(recursiveFlag,
        help:
            'Whether to recursively walk sub-directorys looking for packages.',
        defaultsTo: false);
  }

  @override
  Future<Null> runCommand(ArgResults topLevelResults) async {
    if (topLevelResults.wasParsed('version')) {
      print(packageVersion);
      return null;
    }
    return super.runCommand(topLevelResults);
  }
}
