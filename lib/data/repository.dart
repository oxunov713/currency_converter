import 'dart:convert';

import 'package:dio/dio.dart';

import '../constant/config.dart';
import '../model/model.dart';
import '../service/wrapper.dart';

abstract class ICurrencyRepository {
  CurrencyWrapper get wrapper;

  Future<List<Convert>> getData();
}

class CurrencyRepository implements ICurrencyRepository {
  CurrencyRepository() : wrapper = CurrencyWrapper(dio: _dio);

  static final Dio _dio = Dio(BaseOptions(
    baseUrl: Config.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
  ));

  @override
  final CurrencyWrapper wrapper;

  @override
  Future<List<Convert>> getData() async {
    String response = await wrapper.request("/");

    // Assuming response contains a list of Convert objects
    List<dynamic> dataList = jsonDecode(response);
    return dataList.map((data) => Convert.fromJson(data)).toList();
  }
}
