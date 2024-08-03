
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'bloc/connection/connection_cubit.dart';
import 'bloc/converter/converter_cubit.dart';
import 'controller/controller.dart';
import 'data/repository.dart';
import 'localization/app_localizations.dart';
import 'provider/provider_currency.dart';
import 'ui/home.dart';

class App extends StatelessWidget {
  App({super.key});

  final controller = MainController(repository: CurrencyRepository());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => ConnectionCubit(),
        ),
        BlocProvider(
          create: (_) => CurrencyCubit(controller: controller),
        ),
      ],
      child: Consumer<LocaleProvider>(
        builder: (context, localeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Currency converter",
            locale: localeProvider.locale,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('uz'),
              Locale('ru'),
              Locale('en'),
            ],
            home: HomePage(),
          );
        },
      ),
    );
  }
}
