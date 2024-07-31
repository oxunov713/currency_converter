import 'package:converter/data/repository.dart';
import 'package:converter/model/model.dart';

import '../util/exception.dart';

class MainController {
  MainController({
    required this.repository,
  });

  final ICurrencyRepository repository;

  List<Convert>? models;

  Future<void> getData() async {
    try {
      models = await repository.getData();
    } on UnknownException catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    } on ClientException catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    } on ServerException catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    } on Object catch (error, stackTrace) {
      print(error);
      print(stackTrace);
    }
  }
}
