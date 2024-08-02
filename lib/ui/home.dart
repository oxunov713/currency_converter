import 'package:converter/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/converter_cubit.dart';
import '../bloc/converter_state.dart';
import '../data/repository.dart';
import 'package:country_flags/country_flags.dart';

import '../model/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CurrencyCubit(
          controller: MainController(repository: CurrencyRepository())),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: const Color(0xFFEAEAFE),
        body: BlocBuilder<CurrencyCubit, CurrencyState>(
          builder: (context, state) {
            print('Current state: $state');
            if (state is CurrencyLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is CurrencyLoaded) {
              final cubit = context.read<CurrencyCubit>();

              // Unique country codes to prevent duplicate dropdown values
              final uniqueCountryCodes = {
                for (var item in state.models) item.ccy!,
              }.toList();

              return SafeArea(
                child: Column(
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
                      margin:
                      const EdgeInsets.only(left: 15, right: 15, top: 30),
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
                                state.selectedCountry1.substring(0, 2),
                                height: 50,
                                width: 50,
                                shape: const Circle(),
                              ),
                              DropdownButton<String>(
                                value: state.selectedCountry1,
                                items: uniqueCountryCodes.map((countryCode) {
                                  return DropdownMenuItem<String>(
                                    value: countryCode,
                                    child: Text(
                                      state.models.firstWhere(
                                              (item) => item.ccy == countryCode,
                                          orElse: () => Convert(ccy: countryCode, ccyNm_UZ: countryCode)
                                      ).ccyNm_UZ!,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    cubit.changeCountry1(value!),
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
                              CountryFlag.fromCountryCode(
                                state.selectedCountry2.substring(0, 2),
                                height: 50,
                                width: 50,
                                shape: const Circle(),
                              ),
                              DropdownButton<String>(
                                value: state.selectedCountry2,
                                items: uniqueCountryCodes.map((countryCode) {
                                  return DropdownMenuItem<String>(
                                    value: countryCode,
                                    child: Text(
                                      state.models.firstWhere(
                                              (item) => item.ccy == countryCode,
                                          orElse: () => Convert(ccy: countryCode, ccyNm_UZ: countryCode)
                                      ).ccyNm_UZ!,
                                    ),
                                  );
                                }).toList(),
                                onChanged: (value) =>
                                    cubit.changeCountry2(value!),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                                    final amount = double.tryParse(value) ?? 0;
                                    final rate1 = double.tryParse(state.rate1) ?? 0;
                                    final rate2 = double.tryParse(state.rate2) ?? 0;
                                    final convertedAmount = amount * (rate2 / rate1);
                                    // Update the UI with the calculated result
                                    cubit.emit(CurrencyLoaded(
                                      models: state.models,
                                      selectedCountry1: state.selectedCountry1,
                                      selectedCountry2: state.selectedCountry2,
                                      rate1: state.rate1,
                                      rate2: state.rate2,

                                    ));
                                  },
                                  decoration: const InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide:
                                      BorderSide(color: Colors.black26),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                      borderSide:
                                      BorderSide(color: Colors.black),
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
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                                    border: InputBorder.none,
                                    hintText: '0.00',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text("",
                             // "Converted amount: ${state.convertedAmount ?? '0.00'} ${state.selectedCountry2}",
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
                  ],
                ),
              );
            } else if (state is CurrencyError) {
              return Center(child: Text(state.message));
            } else {
              return Center(child: Text('Unknown state'));
            }
          },
        ),
      ),
    );
  }
}

