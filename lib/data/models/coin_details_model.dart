class CoinDetailsModel {
  final String id;
  final String name;
  final String symbol;
  final String? image;
  final int? marketCapRank;
  final String description;
  final double? currentPrice;
  final double? priceChangePercentage24h;
  final double? marketCap;
  final double? totalVolume;
  final double? high24h;
  final double? low24h;
  final double? circulatingSupply;
  final double? totalSupply;
  final double? maxSupply;
  final double? ath;
  final double? atl;

  const CoinDetailsModel({
    required this.id,
    required this.name,
    required this.symbol,
    this.image,
    this.marketCapRank,
    this.description = '',
    this.currentPrice,
    this.priceChangePercentage24h,
    this.marketCap,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.atl,
  });

  factory CoinDetailsModel.fromJson(Map<String, dynamic> json) {
    final marketData = json['market_data'] as Map<String, dynamic>? ?? {};

    final currentPrice =
        marketData['current_price'] as Map<String, dynamic>? ?? {};
    final marketCap = marketData['market_cap'] as Map<String, dynamic>? ?? {};
    final totalVolume =
        marketData['total_volume'] as Map<String, dynamic>? ?? {};
    final high24h = marketData['high_24h'] as Map<String, dynamic>? ?? {};
    final low24h = marketData['low_24h'] as Map<String, dynamic>? ?? {};
    final ath = marketData['ath'] as Map<String, dynamic>? ?? {};
    final atl = marketData['atl'] as Map<String, dynamic>? ?? {};

    final image = json['image'] as Map<String, dynamic>? ?? {};
    final description = json['description'] as Map<String, dynamic>? ?? {};

    return CoinDetailsModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      symbol: json['symbol'] ?? '',
      image: image['large'],
      marketCapRank: json['market_cap_rank'],
      description: description['en'] ?? '',
      currentPrice: _toDouble(currentPrice['usd']),
      priceChangePercentage24h: _toDouble(
        marketData['price_change_percentage_24h'],
      ),
      marketCap: _toDouble(marketCap['usd']),
      totalVolume: _toDouble(totalVolume['usd']),
      high24h: _toDouble(high24h['usd']),
      low24h: _toDouble(low24h['usd']),
      circulatingSupply: _toDouble(marketData['circulating_supply']),
      totalSupply: _toDouble(marketData['total_supply']),
      maxSupply: _toDouble(marketData['max_supply']),
      ath: _toDouble(ath['usd']),
      atl: _toDouble(atl['usd']),
    );
  }

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
