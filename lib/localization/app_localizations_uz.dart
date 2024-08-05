import 'app_localizations.dart';

/// The translations for Uzbek (`uz`).
class AppLocalizationsUz extends AppLocalizations {
  AppLocalizationsUz([String locale = 'uz']) : super(locale);

  @override
  String get appName => 'Valyuta Converter';

  @override
  String get bank => 'O‘zbekiston Markaziy Banki';

  @override
  String get amount => 'Miqdor';

  @override
  String get conAmount => 'O‘zgartirilgan miqdor';

  @override
  String get ps => '* Agar kiritayotgan miqdoringiz katta bo‘lsa, ekraningni aylantiring!';

  @override
  String get intUnavailable => 'Internet mavjud emas';

  @override
  String get check => 'Iltimos, internet ulanishingizni tekshiring.';

  @override
  String get invRate => 'Noto‘g‘ri kurs ma\'lumotlari';

  @override
  String get incompleteCurr => 'Noto‘liq valyuta ma\'lumotlari';

  @override
  String get contacts => 'Kontaktlar';

  @override
  String get moreApps => 'Boshqa dasturlar';

  @override
  String get language => 'Til';

  @override
  String get choseLan => 'Qaysi tilni tanlaysiz';
}
