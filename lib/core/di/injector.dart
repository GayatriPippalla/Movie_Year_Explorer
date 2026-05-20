// NOTE:
// This project currently doesn't include the Users feature models/repositories
// referenced by the previous DI setup.
//
// Keeping this file empty avoids compile-time errors while allowing the Movies
// feature to run.

import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Intentionally left blank.
}

