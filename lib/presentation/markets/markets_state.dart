part of 'markets_cubit.dart';

enum MarketSortType { marketCap, price, change24h, volume, name }

final class MarketsState {
  final List<MarketCoinModel> marketCoins;
  final List<MarketCoinModel> searchResults;
  final int selectedFilterIndex;
  final MarketSortType selectedSortType;
  final bool isSortAscending;
  final bool isSearching;
  final bool isSearchActive;
  final bool isLoading;
  final bool isLoadingMore;
  final bool hasMore;
  final List<String> watchlistCoinIds;

  const MarketsState({
    this.marketCoins = const [],
    this.searchResults = const [],
    this.selectedFilterIndex = 0,
    this.selectedSortType = MarketSortType.marketCap,
    this.isSortAscending = false,
    this.isSearching = false,
    this.isSearchActive = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.hasMore = true,
    this.watchlistCoinIds = const [],
  });

  MarketsState copyWith({
    List<MarketCoinModel>? marketCoins,
    List<MarketCoinModel>? searchResults,
    int? selectedFilterIndex,
    MarketSortType? selectedSortType,
    bool? isSortAscending,
    bool? isSearching,
    bool? isSearchActive,
    bool? isLoading,
    bool? isLoadingMore,
    bool? hasMore,
    List<String>? watchlistCoinIds,
  }) {
    return MarketsState(
      marketCoins: marketCoins ?? this.marketCoins,
      searchResults: searchResults ?? this.searchResults,
      selectedFilterIndex: selectedFilterIndex ?? this.selectedFilterIndex,
      selectedSortType: selectedSortType ?? this.selectedSortType,
      isSortAscending: isSortAscending ?? this.isSortAscending,
      isSearching: isSearching ?? this.isSearching,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      isLoading: isLoading ?? this.isLoading,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
      watchlistCoinIds: watchlistCoinIds ?? this.watchlistCoinIds,
    );
  }
}
