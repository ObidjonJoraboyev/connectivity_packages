import 'package:connectivity_packages/data/models/currency.dart';
import 'package:equatable/equatable.dart';

class CurrencyStateCubit extends Equatable {
  final List<CurrencyModel>? currencies;
  final String? errorMessage;
  final bool isLoading;

  const CurrencyStateCubit({
    this.currencies,
    this.errorMessage,
    this.isLoading = false,
  });

  factory CurrencyStateCubit.initial() {
    return const CurrencyStateCubit();
  }

  factory CurrencyStateCubit.loading() {
    return const CurrencyStateCubit(isLoading: true);
  }

  factory CurrencyStateCubit.success(List<CurrencyModel> currencies) {
    return CurrencyStateCubit(currencies: currencies);
  }

  factory CurrencyStateCubit.error(String errorMessage) {
    return CurrencyStateCubit(errorMessage: errorMessage);
  }

  @override
  List<Object?> get props => [currencies, errorMessage, isLoading];
}
