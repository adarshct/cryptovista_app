part of 'coin_details_cubit.dart';

final class CoinDetailsState {
  final CoinDetailsModel? coin;
  final CoinChartModel? chart;
  final int selectedDays;
  final bool isLoading;
  final bool isChartLoading;
  final bool isWatchlisted;
  final bool isWatchlistUpdating;
  final String error;
  final String chartError;

  const CoinDetailsState({
    this.coin,
    this.chart,
    this.selectedDays = 7,
    this.isLoading = false,
    this.isChartLoading = false,
    this.isWatchlisted = false,
    this.isWatchlistUpdating = false,
    this.error = '',
    this.chartError = '',
  });

  CoinDetailsState copyWith({
    CoinDetailsModel? coin,
    CoinChartModel? chart,
    int? selectedDays,
    bool? isLoading,
    bool? isChartLoading,
    bool? isWatchlisted,
    bool? isWatchlistUpdating,
    String? error,
    String? chartError,
  }) {
    return CoinDetailsState(
      coin: coin ?? this.coin,
      chart: chart ?? this.chart,
      selectedDays: selectedDays ?? this.selectedDays,
      isLoading: isLoading ?? this.isLoading,
      isChartLoading: isChartLoading ?? this.isChartLoading,
      isWatchlisted: isWatchlisted ?? this.isWatchlisted,
      isWatchlistUpdating: isWatchlistUpdating ?? this.isWatchlistUpdating,
      error: error ?? this.error,
      chartError: chartError ?? this.chartError,
    );
  }
}
