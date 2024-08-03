import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:converter/controller/controller.dart';

import '../../model/model.dart';
import 'converter_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final MainController controller;
  List<Convert> models = [];
  double convertedCurrency = 0;
  late Convert selectedCountry1;
  late Convert selectedCountry2;
  String input = "0";

  CurrencyCubit({required this.controller}) : super(CurrencyInitial()) {
    fetchData();
  }

  Future<void> fetchData() async {
    emit(CurrencyLoading());

    try {
      final data = await controller.getData();
      models = data;
      models.add(
        Convert(
          ccy: "UZS",
          ccyNm_RU: "Узбекский Cум",
          ccyNm_EN: "Uzbek soum",
          ccyNm_UZ: "O'zbek so'mi",
          ccyNm_UZC: "Узбек суми",
          code: "000",
          date: models[0].date,
          diff: "0",
          id: 0,
          nominal: "1",
          rate: "1",
        ),
      );
      int n1 = Random().nextInt(models.length);
      int n2 = Random().nextInt(models.length);
      selectedCountry1 = models[n1];
      selectedCountry2 = models[n2];

      emit(
        CurrencyLoaded(
          models: models,
          convertedCurrency: convertedCurrency,
          selectedCountry1: selectedCountry1,
          selectedCountry2: selectedCountry2,
        ),
      );
    } catch (e) {
      print("Error fetching data: $e");
      emit(CurrencyError('Failed to load data'));
    }
  }

  void changeCountry1(String? countryCode) {
    selectedCountry1 = models.firstWhere((e) => e.ccy == countryCode);
    exchangeCurrency(input);
    emit(CurrencyLoaded(
      models: models,
      convertedCurrency: convertedCurrency,
      selectedCountry1: selectedCountry1,
      selectedCountry2: selectedCountry2,
    ));
  }

  void changeCountry2(String? countryCode) {
    selectedCountry2 = models.firstWhere((e) => e.ccy == countryCode);
    exchangeCurrency(input);
    emit(CurrencyLoaded(
      models: models,
      convertedCurrency: convertedCurrency,
      selectedCountry1: selectedCountry1,
      selectedCountry2: selectedCountry2,
    ));
  }

  void exchangeCountry() {
    final temp = selectedCountry1;
    selectedCountry1 = selectedCountry2;
    selectedCountry2 = temp;

    exchangeCurrency(input);
    emit(CurrencyLoaded(
      models: models,
      convertedCurrency: convertedCurrency,
      selectedCountry1: selectedCountry1,
      selectedCountry2: selectedCountry2,
    ));
  }

  void exchangeCurrency(String value) {
    input = value;

    double fromRate = double.tryParse(selectedCountry1.rate ?? "0") ?? 0;
    double toRate = double.tryParse(selectedCountry2.rate ?? "0") ?? 0;


    double amountInBase = (double.tryParse(input) ?? 0) * fromRate;
    if (toRate != 0) {
      convertedCurrency = amountInBase / toRate;
    }


    emit(CurrencyLoaded(
      models: models,
      convertedCurrency: convertedCurrency,
      selectedCountry1: selectedCountry1,
      selectedCountry2: selectedCountry2,
    ));
  }
}