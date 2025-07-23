import 'package:cocoexplorer_mobile/constants/cats.dart';
import 'package:cocoexplorer_mobile/utils/extensions/list_extension.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/tag_search_app_bar.dart';
import 'package:cocoexplorer_mobile/view/home/widgets/home_body.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TagSearchAppBar(availableTags: catNames.takeRandom(10)),
      body: HomeBody(),
    );
  }
}
