import 'package:cocoexplorer_mobile/configs/app_configs.dart';
import 'package:cocoexplorer_mobile/l10n/app_localizations.dart';
import 'package:cocoexplorer_mobile/res/app_theme.dart';
import 'package:cocoexplorer_mobile/res/image_assets.dart';
import 'package:cocoexplorer_mobile/services/navigation/navigation_service.dart';
import 'package:cocoexplorer_mobile/services/router/pager.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage(ImageAssets.logo), context);
    return MaterialApp(
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,
      navigatorKey: NavigationService.instance.navigationKey,
      locale: const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: Pager.splash,
      theme: getTheme(isDark: false),
    );
  }
}
