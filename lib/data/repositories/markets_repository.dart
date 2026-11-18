import 'package:cryptovista_app/core/constants/api_paths.dart';
import 'package:cryptovista_app/core/utils/my_dio.dart';
import 'package:cryptovista_app/data/models/coin_chart_model.dart';
import 'package:cryptovista_app/data/models/coin_details_model.dart';
import 'package:cryptovista_app/data/models/market_coin_model.dart';

abstract class MarketsRepository {
  static Future<dynamic> getMarketCoins({
    int page = 1,
    int perPage = 20,
    String sortBy = 'market_cap_desc',
    int filter = 0,
  }) async {
    final resp = await MyDio().get(
      path: ApiPaths.marketCoins,
      queryParameters: {
        'page': page,
        'per_page': perPage,
        'sort_by': sortBy,
        'filter': filter,
      },
    );

    if (resp is Map<String, dynamic> && resp.containsKey('data')) {
      final data = List.from(resp['data']);

      return data.map((e) => MarketCoinModel.fromJson(e)).toList();
    }
  }

  static Future<dynamic> searchCoins({required String query}) async {
    final resp = await MyDio().get(
      path: ApiPaths.searchCoins,
      queryParameters: {'query': query.trim()},
    );

    if (resp is Map<String, dynamic> && resp.containsKey('data')) {
      final data = List.from(resp['data']);

      return data
          .map(
            (e) => MarketCoinModel.fromSearchJson(Map<String, dynamic>.from(e)),
          )
          .toList();
    }
  }

  static Future<CoinDetailsModel?> getCoinDetails({
    required String coinId,
  }) async {
    final resp = await MyDio().get(path: '${ApiPaths.coinDetails}/$coinId');

    if (resp is Map<String, dynamic> && resp.containsKey('data')) {
      return CoinDetailsModel.fromJson(Map<String, dynamic>.from(resp['data']));
    }

    return null;
  }

  static Future<CoinChartModel?> getCoinChart({
    required String coinId,
    int days = 7,
  }) async {
    final resp = await MyDio().get(
      path: '${ApiPaths.coinChart}/$coinId/chart',
      queryParameters: {'days': days},
    );

    if (resp is Map<String, dynamic> && resp.containsKey('data')) {
      return CoinChartModel.fromJson(Map<String, dynamic>.from(resp['data']));
    }

    return null;
  }
}
