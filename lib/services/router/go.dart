import 'package:cocoexplorer_mobile/res/app_durations.dart';
import 'package:cocoexplorer_mobile/services/navigation/navigation_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Go {
  const Go._();

  static BuildContext get _context => NavigationService.instance.context;

  static CupertinoPageRoute _route<T>(Widget page) =>
      CupertinoPageRoute<T>(builder: (_) => page);

  static PageRoute<T> _createFadeRoute<T>(
    Widget page, {
    Duration duration = AppDurations.ms500,
  }) {
    return PageRouteBuilder(
      transitionDuration: duration,
      pageBuilder: (context, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        // Define fade transition
        var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(animation);
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }

  static Future<T?> to<T>(Widget page) =>
      Navigator.push<T>(_context, _route<T>(page) as Route<T>);

  static void replaceWithFade(
    Widget page, {
    Duration duration = AppDurations.ms500,
  }) => Navigator.pushReplacement(
    _context,
    _createFadeRoute(page, duration: duration),
  );

  static void replace(Widget page) =>
      Navigator.pushReplacement(_context, _route(page));

  static void removeAll(Widget page) => Navigator.pushAndRemoveUntil(
    _context,
    MaterialPageRoute(builder: (_) => page),
    (_) => false,
  );
  static Future<void> back<T>({T? result}) async =>
      Navigator.of(_context).pop<T>(result);
  static Future<bool> canBack<T>({T? result}) async =>
      Navigator.of(_context).canPop();
}
