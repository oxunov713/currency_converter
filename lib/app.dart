import 'package:converter/bloc/converter_cubit.dart';
import 'package:converter/controller/controller.dart';
import 'package:converter/data/repository.dart';
import 'package:converter/ui/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  App({super.key});

  final controller = MainController(repository: CurrencyRepository());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyCubit(controller: controller),
      child: const MaterialApp(

        debugShowCheckedModeBanner: false,
        title: "Currency converter",
        home: HomePage(),
      ),
    );
  }
}
