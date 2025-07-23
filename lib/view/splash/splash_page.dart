import 'package:cocoexplorer_mobile/res/image_assets.dart';
import 'package:cocoexplorer_mobile/services/router/go.dart';
import 'package:cocoexplorer_mobile/services/router/pager.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    goToHome();
    super.initState();
  }

  void goToHome() async {
    await Future.delayed(Duration(seconds: 1));
    Go.replaceWithFade(Pager.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Image.asset(ImageAssets.logo),
        ),
      ),
    );
  }
}
