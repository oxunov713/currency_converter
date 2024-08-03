import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';

import 'connection_state.dart';

class ConnectionCubit extends Cubit<ConnectionState1> {
  late final Connectivity _connectivity;
  late final Stream<ConnectivityResult> _connectivityStream;

  ConnectionCubit() : super(ConnectionInitial()) {
    _connectivity = Connectivity();
    _connectivityStream = _connectivity.onConnectivityChanged;
    _initConnectivity();
    _connectivityStream.listen((result) {
      _updateConnectionStatus(result);
    });
  }

  Future<void> _initConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    final hasInternet = result == ConnectivityResult.mobile || result == ConnectivityResult.wifi;
    emit(ConnectionDone(hasInternet: hasInternet));
  }

  Future<void> checkInternetConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }
}
