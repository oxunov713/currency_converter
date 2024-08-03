import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/connection/connection_cubit.dart';
import '../bloc/connection/connection_state.dart';
import '../bloc/converter/converter_cubit.dart';
import '../bloc/converter/converter_state.dart';
import 'package:country_flags/country_flags.dart';
import '../localization/app_localizations.dart';
import '../provider/provider_currency.dart';
import '../service/url_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final goUrl = UrlService();

  @override
  void initState() {
    super.initState();
    context.read<ConnectionCubit>().checkInternetConnection();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _refreshData() async {
    await context.read<CurrencyCubit>().fetchData();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    bool isPortrait = (orientation == Orientation.portrait);
    final loc = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFEAEAFE),
      appBar: AppBar(
        backgroundColor: const Color(0xFFEAEAFE),
        actions: [
          PopupMenuButton(
            iconSize: 25,
            itemBuilder: (context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: ListTile(
                  onTap: () => goUrl.flaunchURl(
                      Uri.parse("https://www.instagram.com/oxunov_713"), false),
                  title: Text(loc.contacts),
                  leading: const Icon(Icons.phone),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () => goUrl.flaunchURl(
                      Uri.parse("https://t.me/tonyblack_industries"), false),
                  title: Text(loc.moreApps),
                  leading: const Icon(Icons.add),
                ),
              ),
              PopupMenuItem(
                child: ListTile(
                  onTap: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text(loc.language),
                        content: Text(loc.choseLan),
                        actions: [
                          TextButton(
                            onPressed: () {
                              context
                                  .read<LocaleProvider>()
                                  .setLocale(const Locale("uz"));
                              Navigator.pop(context);
                            },
                            child: const Text("Uzbek"),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<LocaleProvider>()
                                  .setLocale(const Locale("ru"));
                              Navigator.pop(context);
                            },
                            child: const Text("Russian"),
                          ),
                          TextButton(
                            onPressed: () {
                              context
                                  .read<LocaleProvider>()
                                  .setLocale(const Locale("en"));
                              Navigator.pop(context);
                            },
                            child: const Text("English"),
                          ),
                        ],
                      ),
                    );
                  },
                  title: Text(loc.language),
                  leading: const Icon(Icons.language),
                ),
              ),
            ],
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => context.read<CurrencyCubit>().fetchData(),
        child: BlocListener<ConnectionCubit, ConnectionState1>(
          listener: (context, connectionState) {
            if (connectionState is ConnectionDone &&
                !connectionState.hasInternet) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(loc.intUnavailable),
                    content: Text(loc.check),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("ok"),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: BlocBuilder<CurrencyCubit, CurrencyState>(
            builder: (context, currencyState) {
              if (currencyState is CurrencyLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (currencyState is CurrencyLoaded) {
                String formattedCurrency = NumberFormat('#,##0.00', 'en_US')
                    .format(currencyState.convertedCurrency);

                String oneCurrency = "";

                if (currencyState.selectedCountry1.rate != null &&
                    currencyState.selectedCountry2.rate != null) {
                  double? rate1 =
                      double.tryParse(currencyState.selectedCountry1.rate!);
                  double? rate2 =
                      double.tryParse(currencyState.selectedCountry2.rate!);

                  if (rate1 != null && rate2 != null && rate2 != 0) {
                    double conversionRate = rate1 / rate2;
                    String conversionRateString =
                        conversionRate.toStringAsFixed(
                            6); // Formats the rate to 6 decimal places
                    oneCurrency =
                        "${currencyState.selectedCountry1.nominal} ${currencyState.selectedCountry1.ccy} = $conversionRateString ${currencyState.selectedCountry2.ccy}";
                  } else {
                    oneCurrency = loc.invRate;
                  }
                } else {
                  oneCurrency = loc.incompleteCurr;
                }
                return ListView(
                  children: [
                    // Custom appbar
                    Text(
                      loc.appName,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 35,
                        color: Color(0xFF1F2261),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      loc.bank,
                      style: const TextStyle(
                        fontSize: 15,
                        color: Color(0xFF808080),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        "${currencyState.models[0].date}",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    // Card
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
                              vertical: 15, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Amount
                              Text(
                                loc.amount,
                                style: const TextStyle(
                                  fontSize: 15,
                                  color: Color(0xFF989898),
                                ),
                              ),
                              const SizedBox(height: 15),
                              // Country1
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CountryFlag.fromCountryCode(
                                    currencyState.selectedCountry1.ccy!
                                        .substring(0, 2),
                                    height: 50,
                                    width: isPortrait ? 50 : 120,
                                    shape: isPortrait
                                        ? const Circle()
                                        : const RoundedRectangle(5),
                                  ),
                                  (double.tryParse(currencyState
                                              .selectedCountry1.diff!)! <
                                          0)
                                      ? const Icon(
                                          Icons.arrow_downward_sharp,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.arrow_upward_sharp,
                                          color: Colors.green,
                                        ),
                                  DropdownMenu<String>(
                                    width: 200,
                                    initialSelection:
                                        currencyState.selectedCountry1.ccy,
                                    dropdownMenuEntries: [
                                      for (var item in currencyState.models)
                                        DropdownMenuEntry<String>(
                                          value: item.ccy!,
                                          label: item.getLocalizedName(context),
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
                                    icon: const Icon(
                                      Icons.swap_vert,
                                      size: 30,
                                    )),
                              ),
                              // Converted amount
                              Text(
                                loc.conAmount,
                                style: const TextStyle(
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
                                    currencyState.selectedCountry2.ccy!
                                        .substring(0, 2),
                                    height: 50,
                                    width: isPortrait ? 50 : 120,
                                    shape: isPortrait
                                        ? const Circle()
                                        : const RoundedRectangle(5),
                                  ),
                                  (double.tryParse(currencyState
                                              .selectedCountry2.diff!)! <
                                          0)
                                      ? const Icon(
                                          Icons.arrow_downward_sharp,
                                          color: Colors.red,
                                        )
                                      : const Icon(
                                          Icons.arrow_upward_sharp,
                                          color: Colors.green,
                                        ),
                                  DropdownMenu<String>(
                                    width: 200,
                                    initialSelection:
                                        currencyState.selectedCountry2.ccy,
                                    dropdownMenuEntries: [
                                      for (var item in currencyState.models)
                                        DropdownMenuEntry<String>(
                                          value: item.ccy!,
                                          label: item.getLocalizedName(context),
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
                                      controller: _controller,
                                      style: const TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        // Remove commas from the value before parsing
                                        String sanitizedValue =
                                            value.replaceAll(',', '');
                                        context
                                            .read<CurrencyCubit>()
                                            .exchangeCurrency(sanitizedValue);
                                        // Format the text and update the controller
                                        String formattedValue =
                                            NumberFormat('#,##0', 'en_US')
                                                .format(double.tryParse(
                                                        sanitizedValue) ??
                                                    0);
                                        _controller.value =
                                            _controller.value.copyWith(
                                          text: formattedValue,
                                          selection: TextSelection.collapsed(
                                              offset: formattedValue.length),
                                        );
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
                                              Radius.circular(20)),
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
                                            Radius.circular(20)),
                                      ),
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 5),
                                          child: Text(
                                            formattedCurrency,
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
                              // Date
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
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 18),
                            child: Text(
                              loc.ps,
                              style: const TextStyle(
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
                );
              } else if (currencyState is CurrencyError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(currencyState.message),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(loc.check),
                      const SizedBox(
                        height: 5,
                      ),
                      FloatingActionButton(
                          onPressed: () => _refreshData(),
                          child: const Icon(Icons.refresh))
                    ],
                  ),
                );
              } else {
                return const Center(child: Text('Unknown state'));
              }
            },
          ),
        ),
      ),
    );
  }
}
