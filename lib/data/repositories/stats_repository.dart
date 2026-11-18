import 'package:cryptovista_app/core/constants/api_paths.dart';
import 'package:cryptovista_app/core/utils/my_dio.dart';
import 'package:cryptovista_app/data/models/global_market_stats_model.dart';

class StatsRepository {
  static Future<GlobalMarketStatsModel?> getGlobalMarketStats() async {
    final resp = await MyDio().get(path: ApiPaths.globalMarketStats);

    if (resp is Map<String, dynamic> && resp['data'] is Map) {
      return GlobalMarketStatsModel.fromJson(
        Map<String, dynamic>.from(resp['data']),
      );
    }

    return null;
  }
}
