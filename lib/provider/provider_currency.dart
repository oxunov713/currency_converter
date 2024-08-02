// import 'package:flutter/material.dart';
//
// import '../controller/controller.dart';
// import '../data/repository.dart';
//
// class CurrencyProvider extends ChangeNotifier {
//   late final MainController controller;
//   bool isTyping = false;
//   double sum = 0;
//   double from = 0;
//   double to = 0;
//   double amount = 0;
//   double conv_amout = 0;
//   String selectedCountry1 = 'USD';
//   String selectedCountry2 = 'SGP';
//   String rate1 = '';
//   String rate2 = '';
//
//   CurrencyProvider() {
//     controller = MainController(repository: CurrencyRepository());
//     _fetchData();
//   }
//
//   Future<void> _fetchData() async {
//     try {
//       await controller.getData();
//       notifyListeners();
//     } catch (e) {
//       print('Failed to load data: $e');
//     }
//   }
//
//   void changeCountry1(String? value) {
//     rate1 =
//         controller.models!.firstWhere((element) => element.ccy == value).rate!;
//     selectedCountry1 =
//         controller.models!.firstWhere((element) => element.ccy == value).ccy!;
//     amount = double.tryParse(rate1)!;
//     notifyListeners();
//   }
//
//   void typing() {
//     isTyping = !isTyping;
//     notifyListeners();
//   }
//
//   void changeCountry2(String? value) {
//     rate2 =
//         controller.models!.firstWhere((element) => element.ccy == value).rate!;
//     selectedCountry2 =
//         controller.models!.firstWhere((element) => element.ccy == value).ccy!;
//     amount = double.tryParse(rate2)!;
//     notifyListeners();
//   }
// }
