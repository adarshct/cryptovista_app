class GlobalMarketStatsModel {
  final double? totalMarketCap;
  final double? totalVolume;
  final double? marketCapChangePercentage24h;
  final double? btcDominance;
  final double? ethDominance;
  final int? activeCryptocurrencies;
  final int? activeMarkets;
  final int? activeExchanges;

  const GlobalMarketStatsModel({
    this.totalMarketCap,
    this.totalVolume,
    this.marketCapChangePercentage24h,
    this.btcDominance,
    this.ethDominance,
    this.activeCryptocurrencies,
    this.activeMarkets,
    this.activeExchanges,
  });

  factory GlobalMarketStatsModel.fromJson(Map<String, dynamic> json) {
    final marketCap = json['total_market_cap'] as Map<String, dynamic>? ?? {};
    final volume = json['total_volume'] as Map<String, dynamic>? ?? {};
    final marketCapPercentage =
        json['market_cap_percentage'] as Map<String, dynamic>? ?? {};

    return GlobalMarketStatsModel(
      totalMarketCap: _toDouble(marketCap['usd']),
      totalVolume: _toDouble(volume['usd']),
      marketCapChangePercentage24h: _toDouble(
        json['market_cap_change_percentage_24h_usd'],
      ),
      btcDominance: _toDouble(marketCapPercentage['btc']),
      ethDominance: _toDouble(marketCapPercentage['eth']),
      activeCryptocurrencies: _toInt(json['active_cryptocurrencies']),
      activeMarkets: _toInt(json['markets']),
      activeExchanges: _toInt(json['active_exchanges']),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }

  static int? _toInt(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toInt();
    return int.tryParse(value.toString());
  }
}
