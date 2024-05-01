import '../api_provider.dart';
import '../response/response.dart';

class CurrencyRepository {
  CurrencyRepository({required this.apiProvider});

  final ApiProvider apiProvider;

  Future<NetworkResponse> getAll() async =>
      await apiProvider.getAllCurrencies();
}
