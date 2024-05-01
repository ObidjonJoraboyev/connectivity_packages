import 'package:equatable/equatable.dart';

import '../data/models/currency.dart';

abstract class CurrencyState extends Equatable {
  const CurrencyState();

  @override
  List<Object?> get props => throw UnimplementedError();
}

class CurrencyInitialState extends CurrencyState {
  @override
  List<Object> get props => [];
}

class CurrencyGetState extends CurrencyState {
  final List<CurrencyModel> currencies;

  const CurrencyGetState({
    required this.currencies,
  });

  @override
  List<Object> get props => [];
}

class CurrencyGetStateFrom extends CurrencyState {
  final List<CurrencyModel> currencies;

  const CurrencyGetStateFrom({
    required this.currencies,
  });

  @override
  List<Object> get props => [];
}

class CurrencyErrorState extends CurrencyState {
  final String errorText;

  const CurrencyErrorState({
    required this.errorText,
  });

  @override
  List<Object> get props => [];
}
