class MarketCoinModel {
  final String? id;
  final String? symbol;
  final String? name;
  final String? image;
  final double? currentPrice;
  final double? priceChangePercentage24h;
  final double? marketCap;
  final int? marketCapRank;
  final double? totalVolume;

  const MarketCoinModel({
    this.id,
    this.symbol,
    this.name,
    this.image,
    this.currentPrice,
    this.priceChangePercentage24h,
    this.marketCap,
    this.marketCapRank,
    this.totalVolume,
  });

  factory MarketCoinModel.fromJson(Map<String, dynamic> json) {
    return MarketCoinModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      currentPrice: (json['current_price'] ?? 0).toDouble(),
      priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0)
          .toDouble(),
      marketCap: (json['market_cap'] ?? 0).toDouble(),
      marketCapRank: json['market_cap_rank'] ?? 0,
      totalVolume: (json['total_volume'] ?? 0).toDouble(),
    );
  }

  factory MarketCoinModel.fromSearchJson(Map<String, dynamic> json) {
    return MarketCoinModel(
      id: json['id'] ?? '',
      symbol: json['symbol'] ?? '',
      name: json['name'] ?? '',
      image: json['thumb'] ?? json['large'] ?? '',
      marketCapRank: json['market_cap_rank'] ?? 0,
    );
  }
}

// class MarketCoinModel {
//   final String? id;
//   final String? symbol;
//   final String? name;
//   final String? image;
//   final double? currentPrice;
//   final double? priceChangePercentage24h;
//   final double? marketCap;
//   final int? marketCapRank;
//   final double? totalVolume;

//   const MarketCoinModel({
//     this.id,
//     this.symbol,
//     this.name,
//     this.image,
//     this.currentPrice,
//     this.priceChangePercentage24h,
//     this.marketCap,
//     this.marketCapRank,
//     this.totalVolume,
//   });

//   factory MarketCoinModel.fromJson(Map<String, dynamic> json) {
//     return MarketCoinModel(
//       id: json['id'] ?? '',
//       symbol: json['symbol'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'] ?? '',
//       currentPrice: (json['current_price'] ?? 0).toDouble(),
//       priceChangePercentage24h: (json['price_change_percentage_24h'] ?? 0)
//           .toDouble(),
//       marketCap: (json['market_cap'] ?? 0).toDouble(),
//       marketCapRank: json['market_cap_rank'] ?? 0,
//       totalVolume: (json['total_volume'] ?? 0).toDouble(),
//     );
//   }
// }
