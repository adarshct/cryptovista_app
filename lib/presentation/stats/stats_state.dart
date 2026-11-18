part of 'stats_cubit.dart';

final class StatsState {
  final GlobalMarketStatsModel? stats;
  final bool isLoading;
  final String error;

  const StatsState({this.stats, this.isLoading = false, this.error = ''});

  StatsState copyWith({
    GlobalMarketStatsModel? stats,
    bool? isLoading,
    String? error,
  }) {
    return StatsState(
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
