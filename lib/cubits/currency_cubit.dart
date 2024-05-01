import 'package:connectivity_packages/data/local/local_database.dart';
import 'package:connectivity_packages/data/models/currency.dart';
import 'package:connectivity_packages/data/network/api_provider.dart';
import 'package:connectivity_packages/data/network/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  final ApiProvider apiProvider = ApiProvider();

  CurrencyCubit() : super(CurrencyInitialState());

  Future<void> getCurrencies() async {
    try {
      final currencies =
          (await CurrencyRepository(apiProvider: apiProvider).getAll()).data
                  as List<CurrencyModel>? ??
              [];

      emit(CurrencyGetState(currencies: currencies));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getCurrenciesFromDatabase() async {
    try {
      final currencies = await LocalDatabase.getAllCurrencies();
      emit(CurrencyGetStateFrom(currencies: currencies));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> deleteCurrencies() async {
    try {
      await LocalDatabase.deleteCurrencyTable();
      emit(const CurrencyGetStateFrom(currencies: []));
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
