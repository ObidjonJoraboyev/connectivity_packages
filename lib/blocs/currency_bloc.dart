import 'package:connectivity_packages/data/local/local_database.dart';
import 'package:connectivity_packages/data/models/currency.dart';
import 'package:connectivity_packages/data/network/api_provider.dart';
import 'package:connectivity_packages/data/network/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'currency_event.dart';
import 'currency_state.dart';

class CurrencyBloc extends Bloc<CurrencyEvent, CurrencyState> {
  ApiProvider apiProvider = ApiProvider();

  CurrencyBloc() : super(CurrencyInitialState()) {
    on<GetCurrencies>(onGetEvent);
    on<GetCurrenciesFromDatabase>(onGetEventFromDatabase);
    on<DeleteCurrencies>(onDeleteCurrencies);
  }

  onGetEvent(GetCurrencies event, Emitter emit) async {
    emit(CurrencyInitialState());

    List<CurrencyModel> currencies =
        (await CurrencyRepository(apiProvider: apiProvider).getAll()).data
                as List<CurrencyModel>? ??
            [];

    emit(CurrencyGetState(currencies: currencies));
  }

  onGetEventFromDatabase(GetCurrenciesFromDatabase event, Emitter emit) async {
    emit(CurrencyInitialState());

    List<CurrencyModel> currencies = await LocalDatabase.getAllCurrencies();
    emit(CurrencyGetStateFrom(currencies: currencies));
  }

  onDeleteCurrencies(DeleteCurrencies event, Emitter emit) async {
    emit(CurrencyInitialState());
    LocalDatabase.deleteCurrencyTable();
    emit(const CurrencyGetStateFrom(currencies: []));
  }
}
