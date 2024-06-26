import 'dart:indexed_db';

import 'package:update_data/currency_model.dart';
import 'package:update_data/network_response.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("todo.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE CurrencyTable (
      title $textType,
      code $textType,
      cb_price $textType,
      nbu_buy_price $textType,
      nbu_cell_price $textType,
      date $textType
    )''');
  }

  static Future<NetworkResponse> insertCurrency(
      CurrencyModel currencyModel) async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      final db = await databaseInstance.database;

      await db.insert("CurrencyTable", currencyModel.toJson());
    } catch (_) {
      networkResponse.errorText = "Hato insertda :(";
    }

    return networkResponse;
  }

  static Future<NetworkResponse> getAllCurrency() async {
    NetworkResponse networkResponse = NetworkResponse();
    try {
      final db = await databaseInstance.database;
      List json = await db.query("CurrencyTable");
      networkResponse.data =
          json.map((e) => CurrencyModel.fromJson(e)).toList();
    } catch (_) {
      networkResponse.errorText = "Error Call Metod";
    }
    return networkResponse;
  }

  static updateCurrency({required CurrencyModel currencyModel}) async {
    final db = await databaseInstance.database;
    await db.update("CurrencyTable", currencyModel.toJson(),
        where: "code = ?", whereArgs: [currencyModel.code]);
  }
}