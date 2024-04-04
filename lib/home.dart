import 'dart:convert';
import 'package:converter/from_json/json.dart';
import 'package:converter/from_json/model.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Convert> converts = List<Map<String, Object?>>.from(jsonDecode(convjson))
      .map(Convert.fromJson)
      .toList();

  double sum = 0;
  double from = 0;
  double to = 0;
  double amount = 0;
  double conv_amout = 0;
  String selectedCountry1 = '';
  String selectedCountry2 = '';
  String rate1 = '';
  String rate2 = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFEAEAFE),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, bottom: 10),
              child: Center(
                child: Text(
                  "Currency Converter",
                  style: TextStyle(
                    fontSize: 35,
                    color: Color(0xFF1F2261),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Check live rates,set rate alerts,receive notifications and more.",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF808080),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15, top: 30),
              height: 350,
              decoration: const BoxDecoration(
                color: Color(0xFFFFFFFF),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Amount",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF989898),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(8),
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
                                "https://cdn-icons-png.flaticon.com/512/197/197496.png"),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu<String>(
                          width: 100,
                          initialSelection: "SGD",
                          dropdownMenuEntries: [
                            for (var item in converts)
                              DropdownMenuEntry<String>(
                                value: item.ccy!,
                                label: item.ccyNm_UZ!,
                              ),
                          ],
                          onSelected: (String? value) {
                            rate1 = converts
                                .firstWhere((element) => element.ccy == value)
                                .rate!;
                            selectedCountry1 = converts
                                .firstWhere((element) => element.ccy == value)
                                .ccy!;
                            amount = double.tryParse(rate1)!;
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 50,
                          width: 140,
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: TextField(
                            textAlign: TextAlign.center,
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              from = double.tryParse(value)!;
                              setState(() {});
                            },
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(color: Colors.black26),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                borderSide: BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: Color(0xFF26278D),
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: const Icon(
                        Icons.currency_exchange,
                        size: 25,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(12),
                    child: Text(
                      "Converted amount",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF989898),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(8),
                            height: 50,
                            width: 50,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: NetworkImage(
                                    "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/United-states_flag_icon_round.svg/1024px-United-states_flag_icon_round.svg.png"),
                              ),
                            ),
                          ),
                          DropdownMenu<String>(
                            width: 150,
                            initialSelection: "USD",
                            dropdownMenuEntries: [
                              for (var item in converts)
                                DropdownMenuEntry<String>(
                                  value: item.ccy!,
                                  label: item.ccyNm_UZ!,
                                ),
                            ],
                            onSelected: (String? value) {
                              rate2 = converts
                                  .firstWhere((element) => element.ccy == value)
                                  .rate!;
                              selectedCountry2 = converts
                                  .firstWhere((element) => element.ccy == value)
                                  .ccy!;
                              conv_amout = double.tryParse(rate2)!;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Color(0xFFEFEFEF),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 7, horizontal: 15),
                            child: Center(
                              child: Text(
                                '$conv_amout',
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15),
              child: Text(
                "Indicative Exchange Rate ",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFA1A1A1),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                " $from $selectedCountry1 = ${(from * conv_amout).toStringAsFixed(3)} $selectedCountry2",
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
