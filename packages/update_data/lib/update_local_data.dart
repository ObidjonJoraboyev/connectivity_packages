import 'package:update_data/currency_model.dart';
import 'package:update_data/local_db.dart';

Future<void> updateLocalDB(CurrencyModel currencyModel) async {
  await LocalDatabase.updateCurrency(currencyModel: currencyModel);
}
