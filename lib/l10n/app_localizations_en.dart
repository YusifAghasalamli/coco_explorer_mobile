// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get searchHint => 'Tip: Use \';\' to convert text into tags';

  @override
  String get defaultError => 'An error occurred. Please try again later.';

  @override
  String get nothingFound => 'No results found. Try a different tag or keyword.';
}
