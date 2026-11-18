import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:cryptovista_app/data/models/market_coin_model.dart';
import 'package:cryptovista_app/presentation/coin_details/coin_details_screen.dart';
import 'package:cryptovista_app/presentation/markets/markets_cubit.dart';
import 'package:cryptovista_app/presentation/markets/widgets/markets_coin_item.dart';
import 'package:cryptovista_app/presentation/markets/widgets/markets_filters.dart';
import 'package:cryptovista_app/presentation/markets/widgets/markets_header.dart';
import 'package:cryptovista_app/presentation/markets/widgets/markets_search_field.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class MarketsScreen extends StatelessWidget {
  const MarketsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => MarketsCubit(),
      child: Scaffold(
        body: BlocBuilder<MarketsCubit, MarketsState>(
          builder: (context, state) {
            final cubit = context.read<MarketsCubit>();

            final List<MarketCoinModel> coins = state.isSearchActive
                ? state.searchResults
                : state.marketCoins;

            return Padding(
              padding: 16.hPad,
              child: Column(
                children: [
                  kToolbarHeight.hBox,
                  const MarketsHeader(),
                  16.hBox,

                  MarketsSearchField(
                    controller: cubit.searchController,
                    onChanged: cubit.searchCoins,
                  ),

                  16.hBox,

                  if (!state.isSearchActive) ...[
                    MarketsFilters(
                      selectedFilterIndex: state.selectedFilterIndex,
                      onFilterSelected: cubit.updateFilterIndex,
                    ),
                    12.hBox,
                    MarketsSorting(
                      selectedSortType: state.selectedSortType,
                      isSortAscending: state.isSortAscending,
                      onSortChanged: (sortType) {
                        cubit.sortCoins(
                          sortType: sortType,
                          ascending: state.isSortAscending,
                        );
                      },
                      onDirectionChanged: () {
                        cubit.sortCoins(
                          sortType: state.selectedSortType,
                          ascending: !state.isSortAscending,
                        );
                      },
                    ),
                  ],

                  10.hBox,

                  Expanded(
                    child: _buildCoinList(
                      coins: coins,
                      state: state,
                      cubit: cubit,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCoinList({
    required List<MarketCoinModel> coins,
    required MarketsState state,
    required MarketsCubit cubit,
  }) {
    if (state.isLoading || state.isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryGreen),
      );
    }

    if (coins.isEmpty) {
      return Center(
        child: AppText(
          state.isSearchActive ? 'No coins found' : 'No market data available',
          color: AppColors.secondaryText,
          size: 13,
        ),
      );
    }

    return ListView.separated(
      controller: state.isSearchActive ? null : cubit.scrollController,
      padding: 0.aPad,
      itemCount:
          coins.length + (!state.isSearchActive && state.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= coins.length) {
          return Padding(
            padding: 20.vPad,
            child: const Center(
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            ),
          );
        }

        final coin = coins[index];
        final coinId = coin.id ?? '';
        final isWatchlisted = state.watchlistCoinIds.contains(coinId);

        return MarketsCoinItem(
          coin: coin,
          onTap: () async {
            await open(
              CoinDetailsScreen(coinId: coinId, isWatchlisted: isWatchlisted),
            );

            await cubit.getWatchlist();
          },
          isWatchlisted: isWatchlisted,
          onWatchlistTap: () async {
            if (isWatchlisted) {
              await cubit.removeFromWatchlist(coinId);
            } else {
              await cubit.addToWatchlist(coinId);
            }
          },
        );
      },
      separatorBuilder: (context, index) => Divider(
        height: 1,
        thickness: 0.6,
        color: AppColors.divider.withValues(alpha: 0.65),
      ),
    );
  }
}
