import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/converter_cubit.dart';
import '../bloc/converter_state.dart';
import 'package:country_flags/country_flags.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEAEAFE),
      body: BlocBuilder<CurrencyCubit, CurrencyState>(
        builder: (context, state) {
          print('Current state: $state');
          if (state is CurrencyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CurrencyLoaded) {
            final orientation = MediaQuery.of(context).orientation;
            bool isPortrait = (orientation == Orientation.portrait);

            String oneCurrency =
                "${state.selectedCountry1.nominal} ${state.selectedCountry1.ccy} = ${"${double.tryParse(state.selectedCountry1.rate!)! / double.tryParse(state.selectedCountry2.rate!)!}".substring(0, 6)} ${state.selectedCountry2.ccy} ";

            return SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    //? Custom appbar
                    const Text(
                      "Currency Converter",
                      style: TextStyle(
                        fontSize: 35,
                        color: Color(0xFF1F2261),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "Central Bank of Uzbekistan",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF808080),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        "${state.models[0].date}",
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    //? Card
                    Card(
                      margin:
                          const EdgeInsets.only(left: 15, right: 15, top: 30),
                      child: DecoratedBox(
                        decoration: const BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //? Amount
                              const Text(
                                "Amount",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF989898),
                                ),
                              ),
                              const SizedBox(height: 15),
                              //? Country1
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryFlag.fromCountryCode(
                                    state.selectedCountry1.ccy!.substring(0, 2),
                                    height: 50,
                                    width: isPortrait ? 50 : 120,
                                    shape: isPortrait
                                        ? const Circle()
                                        : const RoundedRectangle(5),
                                  ),
                                  DropdownMenu<String>(
                                    initialSelection:
                                        state.selectedCountry1.ccy,
                                    dropdownMenuEntries: [
                                      for (var item in state.models)
                                        DropdownMenuEntry<String>(
                                          value: item.ccy!,
                                          label: item.ccyNm_UZ!,
                                        ),
                                    ],
                                    onSelected: (String? value) => context
                                        .read<CurrencyCubit>()
                                        .changeCountry1(value),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 15),
                              Center(
                                child: IconButton(
                                    color: const Color(0xFF1F2261),
                                    onPressed: () => context
                                        .read<CurrencyCubit>()
                                        .exchangeCountry(),
                                    icon: const Icon(Icons.swap_vert)),
                              ),
                              //? Converted amount
                              const Text(
                                "Converted amount",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF989898),
                                ),
                              ),
                              const SizedBox(height: 15),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryFlag.fromCountryCode(
                                    state.selectedCountry2.ccy!.substring(0, 2),
                                    height: 50,
                                    width: isPortrait ? 50 : 120,
                                    shape: isPortrait
                                        ? const Circle()
                                        : const RoundedRectangle(5),
                                  ),
                                  DropdownMenu<String>(
                                    initialSelection:
                                        state.selectedCountry2.ccy,
                                    dropdownMenuEntries: [
                                      for (var item in state.models)
                                        DropdownMenuEntry<String>(
                                          value: item.ccy!,
                                          label: item.ccyNm_UZ!,
                                        ),
                                    ],
                                    onSelected: (String? value) => context
                                        .read<CurrencyCubit>()
                                        .changeCountry2(value),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 30),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: TextField(
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        context
                                            .read<CurrencyCubit>()
                                            .exchangeCurrency(value);
                                      },
                                      decoration: const InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                          borderSide:
                                              BorderSide(color: Colors.green),
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
                                  const SizedBox(width: 3),
                                  const Expanded(
                                    flex: 1,
                                    child: Center(
                                      child: Text(
                                        "=",
                                        style: TextStyle(fontSize: 40),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 3),
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.black, width: 1),
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            "${state.convertedCurrency}",
                                            textAlign: TextAlign.center,
                                            maxLines: 1,
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 24,
                                                overflow: TextOverflow.clip),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              //? Date
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Text(
                                  oneCurrency,
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
                      ),
                    ),
                    isPortrait
                        ? const Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            child: Text(
                              "* Agar sizning kiritayotgan summangiz katta bo'lsa, ekranni aylantiring!",
                              style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : const SizedBox(
                            height: 60,
                          ),
                  ],
                ),
              ),
            );
          } else if (state is CurrencyError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('Unknown state'));
          }
        },
      ),
    );
  }
}
