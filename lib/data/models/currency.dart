class CurrencyModel {
  final String title;
  final String code;
  final String cbPrice;
  final String nbuBuy;
  final String nbuCell;
  final String date;
  final int? id;

  CurrencyModel({
    required this.id,
    required this.title,
    required this.date,
    required this.code,
    required this.cbPrice,
    required this.nbuBuy,
    required this.nbuCell,
  });

  factory CurrencyModel.fromJson(Map<String, dynamic> json) {
    return CurrencyModel(
      id: json["_id"] as int? ?? 0,
      title: json["title"] as String? ?? "",
      date: json["date"] as String? ?? "",
      code: json["code"] as String? ?? "",
      cbPrice: json["cb_price"] as String? ?? "",
      nbuBuy: json["nbu_buy_price"] as String? ?? "",
      nbuCell: json["nbu_cell_price"] as String? ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "date": date,
      "code": code,
      "cb_price": cbPrice,
      "nbu_buy_price": nbuBuy,
      "nbu_cell_price": nbuCell
    };
  }

  CurrencyModel copyWith({
    String? title,
    String? code,
    String? cbPrice,
    String? nbuBuy,
    String? nbuCell,
    String? date,
    int? id,
  }) {
    return CurrencyModel(
        id: id ?? this.id,
        title: title ?? this.title,
        date: date ?? this.date,
        code: code ?? this.code,
        cbPrice: cbPrice ?? this.cbPrice,
        nbuBuy: nbuBuy ?? this.nbuBuy,
        nbuCell: nbuCell ?? this.nbuCell);
  }
}
