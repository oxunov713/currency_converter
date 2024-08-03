import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';
import 'provider/provider_currency.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: App(),
    ),
  );
}
//* todo uzbek sumni dollarga nisbati +
//* todo connection qo'shish
//* todo vizitka qoyish
//* todo localization qo'shish
//* todo refresh
//* todo diagramma
//* todo add intl formatter
