import 'dart:convert';
import 'package:converter/data/repository.dart';
import 'package:converter/model/model.dart';
import 'package:converter/service/api_service.dart';
import 'package:country_flags/country_flags.dart';

import 'package:flutter/material.dart';

import '../controller/controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final MainController _controller;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _controller = MainController(repository: CurrencyRepository());
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      await _controller.getData();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load data: $e';
      });
    }
  }

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
            const Center(
              child: Text(
                "Central Bank of Uzbekistan",
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CountryFlag.fromCountryCode(
                        "_controller.models?.map((e) => e.code==,)",
                        height: 50,
                        width: 50,
                        shape: const Circle(),
                      ),
                      DropdownMenu<String>(
                        initialSelection: "SGD",
                        dropdownMenuEntries: [
                          for (var item in _controller.models!)
                            DropdownMenuEntry<String>(
                              value: item.ccy!,
                              label: item.ccyNm_UZ!,
                            ),
                        ],
                        onSelected: (String? value) {
                          setState(() {});
                        },
                      ),
                    ],
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(
                        height: 50,
                        width: 50,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/United-states_flag_icon_round.svg/1024px-United-states_flag_icon_round.svg.png"),
                            ),
                          ),
                        ),
                      ),
                      DropdownMenu<String>(
                        initialSelection: "USD",
                        dropdownMenuEntries: [
                          for (var item in _controller.models!)
                            DropdownMenuEntry<String>(
                              value: item.ccy!,
                              label: item.ccyNm_UZ!,
                            ),
                        ],
                        onSelected: (String? value) {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
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
                      const Text(
                        "=",
                        style: TextStyle(fontSize: 40),
                      ),
                      Container(
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
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      //   " $from $selectedCountry1 = ${(from * conv_amout).toStringAsFixed(3)} $selectedCountry2",
                      "",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
