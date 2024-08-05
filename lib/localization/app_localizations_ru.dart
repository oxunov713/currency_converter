import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Конвертер валют';

  @override
  String get bank => 'Центральный банк Узбекистана';

  @override
  String get amount => 'Сумма';

  @override
  String get conAmount => 'Конвертированная сумма';

  @override
  String get ps => '* Если вводимая вами сумма велика, поверните экран!';

  @override
  String get intUnavailable => 'Интернет недоступен';

  @override
  String get check => 'Пожалуйста, проверьте ваше интернет-соединение.';

  @override
  String get invRate => 'Неверные данные о курсе';

  @override
  String get incompleteCurr => 'Неполные данные о валюте';

  @override
  String get contacts => 'Контакты';

  @override
  String get moreApps => 'Другие приложения';

  @override
  String get language => 'Язык';

  @override
  String get choseLan => 'Какой язык вы выбираете?';
}
