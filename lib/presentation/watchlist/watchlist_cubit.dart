import 'package:cryptovista_app/data/models/market_coin_model.dart';
import 'package:cryptovista_app/data/repositories/watchlist_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_state.dart';

class WatchlistCubit extends Cubit<WatchlistState> {
  WatchlistCubit() : super(const WatchlistState());

  Future<void> getWatchlist() async {
    safeEmit(state.copyWith(isLoading: true, error: ''));

    try {
      final coins = await WatchlistRepository.getWatchlist();

      safeEmit(state.copyWith(coins: coins, isLoading: false));
    } catch (_) {
      safeEmit(
        state.copyWith(
          isLoading: false,
          error: 'Unable to load your watchlist. Please try again.',
        ),
      );
    }
  }

  Future<void> addToWatchlist(String coinId) async {
    if (state.isUpdating(coinId)) return;

    safeEmit(
      state.copyWith(updatingCoinIds: {...state.updatingCoinIds, coinId}),
    );

    try {
      final success = await WatchlistRepository.addToWatchlist(coinId: coinId);

      if (success) {
        await getWatchlist();
      }
    } catch (_) {
      // Keep the current watchlist if the request fails.
    } finally {
      safeEmit(
        state.copyWith(
          updatingCoinIds: {...state.updatingCoinIds}..remove(coinId),
        ),
      );
    }
  }

  Future<void> removeFromWatchlist(String coinId) async {
    if (state.isUpdating(coinId)) return;

    safeEmit(
      state.copyWith(updatingCoinIds: {...state.updatingCoinIds, coinId}),
    );

    try {
      final success = await WatchlistRepository.removeFromWatchlist(
        coinId: coinId,
      );

      if (success) {
        safeEmit(
          state.copyWith(
            coins: state.coins.where((coin) => coin.id != coinId).toList(),
          ),
        );
      }
    } catch (_) {
      // Keep the current watchlist if the request fails.
    } finally {
      safeEmit(
        state.copyWith(
          updatingCoinIds: {...state.updatingCoinIds}..remove(coinId),
        ),
      );
    }
  }

  bool isWatchlisted(String coinId) {
    return state.coins.any((coin) => coin.id == coinId);
  }

  void safeEmit(WatchlistState newState) {
    if (!isClosed) emit(newState);
  }
}
