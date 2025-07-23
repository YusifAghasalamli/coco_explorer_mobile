import 'package:cocoexplorer_mobile/locator/get_locator.dart';
import 'package:cocoexplorer_mobile/logic/bloc/home_bloc.dart';
import 'package:cocoexplorer_mobile/view/home/home_page.dart';
import 'package:cocoexplorer_mobile/view/splash/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

class Pager {
  static Widget get splash => const SplashPage();

  static Widget get home => BlocProvider(
    create: (context) => HomeBloc(repository: locator.get())..init(),
    child: const HomePage(),
  );
}
