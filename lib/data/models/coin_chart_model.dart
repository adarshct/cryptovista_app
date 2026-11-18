class CoinChartPoint {
  final DateTime time;
  final double price;

  const CoinChartPoint({required this.time, required this.price});

  factory CoinChartPoint.fromJson(List<dynamic> json) {
    return CoinChartPoint(
      time: DateTime.fromMillisecondsSinceEpoch((json[0] as num).toInt()),
      price: (json[1] as num).toDouble(),
    );
  }
}

class CoinChartModel {
  final List<CoinChartPoint> prices;

  const CoinChartModel({required this.prices});

  factory CoinChartModel.fromJson(Map<String, dynamic> json) {
    final priceData = json['prices'] as List<dynamic>? ?? [];

    return CoinChartModel(
      prices: priceData
          .map((item) => CoinChartPoint.fromJson(List<dynamic>.from(item)))
          .toList(),
    );
  }
}
