import 'package:cryptovista_app/data/models/coin_chart_model.dart';
import 'package:cryptovista_app/data/models/coin_details_model.dart';
import 'package:cryptovista_app/data/repositories/markets_repository.dart';
import 'package:cryptovista_app/data/repositories/watchlist_repository.dart';
import 'package:cryptovista_app/presentation/widgets/custom_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'coin_details_state.dart';

class CoinDetailsCubit extends Cubit<CoinDetailsState> {
  CoinDetailsCubit() : super(const CoinDetailsState());

  String? _coinId;
  int _detailsRequestId = 0;
  int _chartRequestId = 0;

  void safeEmit(CoinDetailsState newState) {
    if (!isClosed) emit(newState);
  }

  void setWatchlistStatus(bool isWatchlisted) {
    safeEmit(state.copyWith(isWatchlisted: isWatchlisted));
  }

  Future<void> toggleWatchlist() async {
    final coinId = _coinId;

    if (coinId == null || coinId.isEmpty || state.isWatchlistUpdating) {
      return;
    }

    safeEmit(state.copyWith(isWatchlistUpdating: true));

    try {
      final bool success;

      if (state.isWatchlisted) {
        success = await WatchlistRepository.removeFromWatchlist(coinId: coinId);

        if (isClosed) return;

        if (success) {
          safeEmit(
            state.copyWith(isWatchlisted: false, isWatchlistUpdating: false),
          );

          CustomToast.toast('Removed from Watchlist');
        }
      } else {
        success = await WatchlistRepository.addToWatchlist(coinId: coinId);

        if (isClosed) return;

        if (success) {
          safeEmit(
            state.copyWith(isWatchlisted: true, isWatchlistUpdating: false),
          );

          CustomToast.success('Added to Watchlist');
        }
      }

      if (!success) {
        safeEmit(state.copyWith(isWatchlistUpdating: false));
        CustomToast.error('Unable to update Watchlist');
      }
    } catch (_) {
      safeEmit(state.copyWith(isWatchlistUpdating: false));
      CustomToast.error('Unable to update Watchlist');
    }
  }

  Future<void> getCoinDetails(String coinId) async {
    _coinId = coinId;

    final requestId = ++_detailsRequestId;

    safeEmit(state.copyWith(isLoading: true, error: ''));

    try {
      final coin = await MarketsRepository.getCoinDetails(coinId: coinId);

      if (isClosed || requestId != _detailsRequestId) return;

      if (coin == null) {
        safeEmit(
          state.copyWith(
            isLoading: false,
            error: 'Unable to load coin details.',
          ),
        );
        return;
      }

      safeEmit(state.copyWith(coin: coin, isLoading: false));

      await getCoinChart(days: state.selectedDays);
    } catch (_) {
      if (isClosed || requestId != _detailsRequestId) return;

      safeEmit(
        state.copyWith(
          isLoading: false,
          error: 'Unable to load coin details. Please try again.',
        ),
      );
    }
  }

  Future<void> getCoinChart({required int days}) async {
    final coinId = _coinId;

    if (coinId == null || coinId.isEmpty) return;

    final requestId = ++_chartRequestId;

    safeEmit(
      state.copyWith(selectedDays: days, isChartLoading: true, chartError: ''),
    );

    try {
      final chart = await MarketsRepository.getCoinChart(
        coinId: coinId,
        days: days,
      );

      if (isClosed || requestId != _chartRequestId) return;

      if (chart == null || chart.prices.isEmpty) {
        safeEmit(
          state.copyWith(
            isChartLoading: false,
            chartError: 'No chart data available.',
          ),
        );
        return;
      }

      safeEmit(state.copyWith(chart: chart, isChartLoading: false));
    } catch (_) {
      if (isClosed || requestId != _chartRequestId) return;

      safeEmit(
        state.copyWith(
          isChartLoading: false,
          chartError: 'Unable to load chart data.',
        ),
      );
    }
  }

  void changeChartPeriod(int days) {
    if (state.selectedDays == days || state.isChartLoading) return;

    getCoinChart(days: days);
  }
}
