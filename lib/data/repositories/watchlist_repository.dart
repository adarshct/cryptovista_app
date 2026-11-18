import 'package:cryptovista_app/core/constants/api_paths.dart';
import 'package:cryptovista_app/core/utils/my_dio.dart';
import 'package:cryptovista_app/data/models/market_coin_model.dart';

class WatchlistRepository {
  static Future<List<MarketCoinModel>> getWatchlist() async {
    final resp = await MyDio().get(path: ApiPaths.watchlist);

    if (resp is Map<String, dynamic> && resp['data'] is List) {
      final data = List.from(resp['data']);

      return data
          .map((e) => MarketCoinModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }

    return [];
  }

  static Future<bool> addToWatchlist({required String coinId}) async {
    final resp = await MyDio().post(path: '${ApiPaths.watchlist}/$coinId');

    return resp is Map<String, dynamic> && resp['success'] == true;
  }

  static Future<bool> removeFromWatchlist({required String coinId}) async {
    final resp = await MyDio().delete(path: '${ApiPaths.watchlist}/$coinId');

    return resp is Map<String, dynamic> && resp['success'] == true;
  }
}
