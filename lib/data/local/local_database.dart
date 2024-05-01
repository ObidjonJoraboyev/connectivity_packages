import 'package:connectivity_packages/data/models/currency.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
      _database = await init("currency.db");
      return _database!;
    }
  }

  Future<Database> init(String databaseName) async {
    String internalPath = await getDatabasesPath();

    String path = join(internalPath, databaseName);
    return openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
    const textType = "TEXT NOT NULL";

    await db.execute('''CREATE TABLE currencies(
    _id $idType,
     title $textType,
      date $textType,
      code $textType,
      cb_price $textType,
      nbu_buy_price $textType,
      nbu_cell_price $textType
      )''');
  }

  static Future<CurrencyModel> insertCurrency(
      CurrencyModel currencyModel) async {
    final db = await databaseInstance.database;
    int savedTaskID = await db.insert("currencies", currencyModel.toJson());
    return currencyModel.copyWith(id: savedTaskID);
  }

  static Future<List<CurrencyModel>> getAllCurrencies() async {
    final db = await databaseInstance.database;
    List json = await db.query("currencies");
    return json.map((e) => CurrencyModel.fromJson(e)).toList();
  }

  static Future<int> deleteCurrencyTable() async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete("currencies");
    return deletedId;
  }

  static Future<int> deleteCurrency(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      "currencies",
      where: "_id = ?",
      whereArgs: [id],
    );
    return deletedId;
  }
}
