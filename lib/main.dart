import 'dart:async';
import 'dart:developer';

import 'package:cocoexplorer_mobile/app.dart';
import 'package:cocoexplorer_mobile/locator/setup_locator.dart';
import 'package:cocoexplorer_mobile/utils/app_bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runZonedGuarded(
    () async {
      await init();
      runApp(const App());
    },
    (error, stack) {
      log(error.toString());
    },
  );
}

Future<void> init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await setupLocator();

  Bloc.observer = const AppBlocObserver();
}
