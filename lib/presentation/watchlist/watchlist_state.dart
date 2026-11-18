part of 'watchlist_cubit.dart';

final class WatchlistState {
  final List<MarketCoinModel> coins;
  final bool isLoading;
  final String error;
  final Set<String> updatingCoinIds;

  const WatchlistState({
    this.coins = const [],
    this.isLoading = false,
    this.error = '',
    this.updatingCoinIds = const {},
  });

  bool isUpdating(String coinId) {
    return updatingCoinIds.contains(coinId);
  }

  WatchlistState copyWith({
    List<MarketCoinModel>? coins,
    bool? isLoading,
    String? error,
    Set<String>? updatingCoinIds,
  }) {
    return WatchlistState(
      coins: coins ?? this.coins,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      updatingCoinIds: updatingCoinIds ?? this.updatingCoinIds,
    );
  }
}
