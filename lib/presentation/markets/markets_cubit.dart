import 'dart:async';

import 'package:cryptovista_app/data/models/market_coin_model.dart';
import 'package:cryptovista_app/data/repositories/markets_repository.dart';
import 'package:cryptovista_app/data/repositories/watchlist_repository.dart';
import 'package:cryptovista_app/presentation/widgets/custom_toast.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(const MarketsState()) {
    scrollController.addListener(_onScroll);
    getMarketCoins();
    getWatchlist();
  }

  final searchController = TextEditingController();
  final scrollController = ScrollController();

  static const int _perPage = 20;

  int _currentPage = 1;
  int _marketRequestId = 0;

  Timer? _searchDebounce;
  int _searchRequestId = 0;

  void safeEmit(MarketsState newState) {
    if (!isClosed) emit(newState);
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;

    if (scrollController.position.extentAfter < 300) {
      loadMoreCoins();
    }
  }

  Future<void> getMarketCoins() async {
    final requestId = ++_marketRequestId;

    _currentPage = 1;

    safeEmit(
      state.copyWith(
        marketCoins: [],
        isLoading: true,
        isLoadingMore: false,
        hasMore: true,
      ),
    );

    try {
      final resp = await MarketsRepository.getMarketCoins(
        page: 1,
        perPage: _perPage,
        filter: state.selectedFilterIndex,
      );

      if (isClosed || requestId != _marketRequestId) return;

      if (resp is List<MarketCoinModel>) {
        _currentPage = 1;

        final sortedCoins = _sortCoins(
          List<MarketCoinModel>.from(resp),
          state.selectedSortType,
          state.isSortAscending,
        );

        safeEmit(
          state.copyWith(
            marketCoins: sortedCoins,
            isLoading: false,
            hasMore: resp.length >= _perPage,
          ),
        );
      } else {
        safeEmit(state.copyWith(isLoading: false, hasMore: false));
      }
    } catch (_) {
      if (isClosed || requestId != _marketRequestId) return;

      safeEmit(state.copyWith(isLoading: false, hasMore: false));
    }
  }

  Future<void> loadMoreCoins() async {
    if (state.isLoading ||
        state.isLoadingMore ||
        !state.hasMore ||
        state.isSearchActive) {
      return;
    }

    final requestId = _marketRequestId;
    final nextPage = _currentPage + 1;

    safeEmit(state.copyWith(isLoadingMore: true));

    try {
      final resp = await MarketsRepository.getMarketCoins(
        page: nextPage,
        perPage: _perPage,
        filter: state.selectedFilterIndex,
      );

      if (isClosed || requestId != _marketRequestId) return;

      if (resp is List<MarketCoinModel>) {
        _currentPage = nextPage;

        final sortedCoins = _sortCoins(
          [...state.marketCoins, ...resp],
          state.selectedSortType,
          state.isSortAscending,
        );

        safeEmit(
          state.copyWith(
            marketCoins: sortedCoins,
            isLoadingMore: false,
            hasMore: resp.length >= _perPage,
          ),
        );
      } else {
        safeEmit(state.copyWith(isLoadingMore: false, hasMore: false));
      }
    } catch (_) {
      if (isClosed || requestId != _marketRequestId) return;

      safeEmit(state.copyWith(isLoadingMore: false));
    }
  }

  // SORTING

  void sortCoins({required MarketSortType sortType, required bool ascending}) {
    final sortedCoins = _sortCoins(
      List<MarketCoinModel>.from(state.marketCoins),
      sortType,
      ascending,
    );

    safeEmit(
      state.copyWith(
        selectedSortType: sortType,
        isSortAscending: ascending,
        marketCoins: sortedCoins,
      ),
    );
  }

  List<MarketCoinModel> _sortCoins(
    List<MarketCoinModel> coins,
    MarketSortType sortType,
    bool ascending,
  ) {
    coins.sort((a, b) {
      int result;

      switch (sortType) {
        case MarketSortType.marketCap:
          result = (a.marketCap ?? 0).compareTo(b.marketCap ?? 0);
          break;

        case MarketSortType.price:
          result = (a.currentPrice ?? 0).compareTo(b.currentPrice ?? 0);
          break;

        case MarketSortType.change24h:
          result = (a.priceChangePercentage24h ?? 0).compareTo(
            b.priceChangePercentage24h ?? 0,
          );
          break;

        case MarketSortType.volume:
          result = (a.totalVolume ?? 0).compareTo(b.totalVolume ?? 0);
          break;

        case MarketSortType.name:
          result = (a.name ?? '').toLowerCase().compareTo(
            (b.name ?? '').toLowerCase(),
          );
          break;
      }

      return ascending ? result : -result;
    });

    return coins;
  }

  // FILTER

  void updateFilterIndex(int index) {
    if (state.selectedFilterIndex == index) return;

    safeEmit(state.copyWith(selectedFilterIndex: index));
    getMarketCoins();
  }

  // SEARCH

  void searchCoins(String query) {
    final searchQuery = query.trim();

    _searchDebounce?.cancel();

    final requestId = ++_searchRequestId;

    if (searchQuery.isEmpty) {
      safeEmit(
        state.copyWith(
          searchResults: [],
          isSearching: false,
          isSearchActive: false,
        ),
      );
      return;
    }

    safeEmit(
      state.copyWith(
        isSearchActive: true,
        isSearching: true,
        searchResults: [],
      ),
    );

    _searchDebounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        final resp = await MarketsRepository.searchCoins(query: searchQuery);

        if (isClosed || requestId != _searchRequestId) return;

        if (resp is List<MarketCoinModel>) {
          safeEmit(state.copyWith(searchResults: resp, isSearching: false));
        }
      } catch (_) {
        if (isClosed || requestId != _searchRequestId) return;

        safeEmit(state.copyWith(searchResults: [], isSearching: false));
      }
    });
  }

  void clearSearch() {
    _searchDebounce?.cancel();
    _searchRequestId++;

    searchController.clear();

    safeEmit(
      state.copyWith(
        searchResults: [],
        isSearching: false,
        isSearchActive: false,
      ),
    );
  }

  // WATCHLIST

  Future<void> getWatchlist() async {
    final coins = await WatchlistRepository.getWatchlist();

    safeEmit(
      state.copyWith(
        watchlistCoinIds: coins
            .map((coin) => coin.id ?? '')
            .where((id) => id.isNotEmpty)
            .toList(),
      ),
    );
  }

  Future<void> addToWatchlist(String coinId) async {
    final success = await WatchlistRepository.addToWatchlist(coinId: coinId);

    if (success) {
      CustomToast.success("Added to Watchlist");

      final updatedWatchlist = List<String>.from(state.watchlistCoinIds)
        ..add(coinId);

      safeEmit(state.copyWith(watchlistCoinIds: updatedWatchlist));
    }
  }

  Future<void> removeFromWatchlist(String coinId) async {
    final success = await WatchlistRepository.removeFromWatchlist(
      coinId: coinId,
    );

    if (success) {
      CustomToast.toast("Removed from Watchlist");

      final updatedWatchlist = List<String>.from(state.watchlistCoinIds)
        ..remove(coinId);

      safeEmit(state.copyWith(watchlistCoinIds: updatedWatchlist));
    }
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    searchController.dispose();

    scrollController
      ..removeListener(_onScroll)
      ..dispose();

    return super.close();
  }
}
