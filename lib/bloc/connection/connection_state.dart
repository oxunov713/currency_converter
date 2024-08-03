import 'package:equatable/equatable.dart';

abstract class ConnectionState1 extends Equatable {
  const ConnectionState1();

  @override
  List<Object?> get props => [];
}

class ConnectionInitial extends ConnectionState1 {}

class ConnectionLoading extends ConnectionState1 {}

class ConnectionDone extends ConnectionState1 {
  final bool hasInternet;

  const ConnectionDone({required this.hasInternet});

  @override
  List<Object?> get props => [hasInternet];
}

class ConnectionError extends ConnectionState1 {}
