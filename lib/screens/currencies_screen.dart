import 'package:connectivity_packages/blocs/currency_bloc.dart';
import 'package:connectivity_packages/blocs/currency_event.dart';
import 'package:connectivity_packages/blocs/currency_state.dart';
import 'package:connectivity_packages/data/local/local_database.dart';
import 'package:connectivity_packages/data/models/currency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrenciesScreen extends StatefulWidget {
  const CurrenciesScreen({super.key});

  @override
  State<CurrenciesScreen> createState() => _CurrenciesScreenState();
}

class _CurrenciesScreenState extends State<CurrenciesScreen> {
  List<CurrencyModel> fromDatabase = [];

  init() async {
    fromDatabase = await LocalDatabase.getAllCurrencies();
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Currencies"),
        leading: IconButton(
          onPressed: () {
            context.read<CurrencyBloc>().add(GetCurrenciesFromDatabase());
          },
          icon: const Icon(Icons.data_exploration),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<CurrencyBloc>().add(GetCurrencies());
            },
            icon: const Icon(Icons.earbuds_rounded),
          ),
        ],
      ),
      body: BlocBuilder<CurrencyBloc, CurrencyState>(
        builder: (context, state) {
          if (state is CurrencyGetState) {
            for (int i = 0; i < state.currencies.length; i++) {
              init();
              if (!fromDatabase.contains(state.currencies[i]) &&
                  fromDatabase.isEmpty) {
                LocalDatabase.insertCurrency(state.currencies[i]);
              } else {}
            }
            return Scrollbar(
              child: ListView(children: [
                ...List.generate(
                  state.currencies.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        subtitle:
                            Text("${state.currencies[index].cbPrice} UZS"),
                        title: Text(state.currencies[index].title),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.55,
                        color: Colors.black.withOpacity(.4),
                      )
                    ],
                  ),
                ),
              ]),
            );
          }
          if (state is CurrencyGetStateFrom) {
            return Scrollbar(
              child: ListView(children: [
                GestureDetector(
                    onTap: () {
                      LocalDatabase.deleteCurrencyTable();
                      context
                          .read<CurrencyBloc>()
                          .add(GetCurrenciesFromDatabase());
                    },
                    child: Row(
                      children: [
                        const Icon(Icons.delete),
                        Text(state.currencies.length.toString())
                      ],
                    )),
                ...List.generate(
                  state.currencies.length,
                  (index) => Column(
                    children: [
                      ListTile(
                        onTap: () {},
                        subtitle:
                            Text("${state.currencies[index].cbPrice} UZS"),
                        title: Text(state.currencies[index].title),
                      ),
                      Container(
                        width: double.infinity,
                        height: 0.55,
                        color: Colors.black.withOpacity(.4),
                      )
                    ],
                  ),
                ),
              ]),
            );
          }
          if (state is CurrencyErrorState) {
            return Center(
              child: Text(state.errorText),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
        },
      ),
    );
  }
}
