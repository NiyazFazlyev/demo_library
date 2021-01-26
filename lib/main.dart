import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_demo/Application/application_properties.dart';
import 'package:library_demo/application.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runZonedGuarded(() async {
    await _initializeApplication();
    runApp(MyLibrary());
  }, (_, __) {});
}

Future<void> _initializeApplication() async {
  await ApplicationProperties.load();
}
