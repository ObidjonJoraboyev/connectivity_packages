import 'package:equatable/equatable.dart';

abstract class CurrencyEvent extends Equatable {
  const CurrencyEvent();

  @override
  List<Object?> get props => [];
}

class GetCurrencies extends CurrencyEvent {}

class GetCurrenciesFromDatabase extends CurrencyEvent {}

class ErrorCurrencies extends CurrencyEvent {}

class DeleteCurrencies extends CurrencyEvent {}
