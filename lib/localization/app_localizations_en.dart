import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Currency Converter';

  @override
  String get bank => 'Central Bank of Uzbekistan';

  @override
  String get amount => 'Amount';

  @override
  String get conAmount => 'Converted amount';

  @override
  String get ps => '* If the amount you are entering is large, rotate the screen!';

  @override
  String get intUnavailable => 'Internet unavailable';

  @override
  String get check => 'Please check your internet connection.';

  @override
  String get invRate => 'Invalid rate data';

  @override
  String get incompleteCurr => 'Incomplete currency data';

  @override
  String get contacts => 'Contacts';

  @override
  String get moreApps => 'More apps';

  @override
  String get language => 'Language';

  @override
  String get choseLan => 'Which language do you choose?';
}
