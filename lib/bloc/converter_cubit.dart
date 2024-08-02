import 'package:bloc/bloc.dart';
import 'package:converter/controller/controller.dart';
import '../data/repository.dart';
import '../model/model.dart';
import 'converter_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final MainController controller;
  List<Convert> models = [];
  String selectedCountry1 = 'USD';
  String selectedCountry2 = 'SGP';
  String rate1 = "";
  String rate2 = "";

  CurrencyCubit({required this.controller}) : super(CurrencyInitial()) {
    fetchData();
  }

  Future<void> fetchData() async {
    emit(CurrencyLoading());
    try {
      final data = await controller.getData();
      models = data ?? [];
      _updateRates();
      emit(CurrencyLoaded(
        models: models,
        selectedCountry1: selectedCountry1,
        selectedCountry2: selectedCountry2,
        rate1: rate1,
        rate2: rate2,
      ));
    } catch (e) {
      emit(CurrencyError('Failed to load data'));
    }
  }

  void changeCountry1(String countryCode) {
    if (selectedCountry1 != countryCode) {
      selectedCountry1 = countryCode;
      _updateRates();
      emit(CurrencyLoaded(
        models: models,
        selectedCountry1: selectedCountry1,
        selectedCountry2: selectedCountry2,
        rate1: rate1,
        rate2: rate2,
      ));
    }
  }

  void changeCountry2(String countryCode) {
    if (selectedCountry2 != countryCode) {
      selectedCountry2 = countryCode;
      _updateRates();
      emit(CurrencyLoaded(
        models: models,
        selectedCountry1: selectedCountry1,
        selectedCountry2: selectedCountry2,
        rate1: rate1,
        rate2: rate2,
      ));
    }
  }

  void _updateRates() {
    rate1 = models
        .firstWhere((e) => e.ccy == selectedCountry1,
            orElse: () => Convert(ccy: selectedCountry1, rate: "0"))
        .rate!;
    rate2 = models
        .firstWhere((e) => e.ccy == selectedCountry2,
            orElse: () => Convert(ccy: selectedCountry2, rate: "0"))
        .rate!;
  }
}
