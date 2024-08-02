import 'package:equatable/equatable.dart';
import '../model/model.dart';

abstract class CurrencyState extends Equatable {
  @override
  List<Object> get props => [];
}

class CurrencyInitial extends CurrencyState {}

class CurrencyLoading extends CurrencyState {}

class CurrencyLoaded extends CurrencyState {
  final List<Convert> models;
  final double convertedCurrency;
  final Convert selectedCountry1;
  final Convert selectedCountry2;

  CurrencyLoaded({
    required this.convertedCurrency,
    required this.models,
    required this.selectedCountry1,
    required this.selectedCountry2,
  });

  @override
  List<Object> get props =>
      [models, selectedCountry1, selectedCountry2, convertedCurrency];
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);

  @override
  List<Object> get props => [message];
}
