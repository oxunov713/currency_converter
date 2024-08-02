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
  final String selectedCountry1;
  final String selectedCountry2;
  final String rate1;
  final String rate2;

  CurrencyLoaded({
    required this.models,
    required this.selectedCountry1,
    required this.selectedCountry2,
    required this.rate1,
    required this.rate2,
  });

  @override
  List<Object> get props =>
      [models, selectedCountry1, selectedCountry2, rate1, rate2];
}

class CurrencyError extends CurrencyState {
  final String message;

  CurrencyError(this.message);

  @override
  List<Object> get props => [message];
}
