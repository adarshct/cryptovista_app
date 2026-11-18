import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:cryptovista_app/presentation/coin_details/coin_details_screen.dart';
import 'package:cryptovista_app/presentation/markets/widgets/markets_coin_item.dart';
import 'package:cryptovista_app/presentation/watchlist/widgets/watchlist_empty.dart';
import 'package:cryptovista_app/presentation/watchlist/widgets/watchlist_error.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:cryptovista_app/presentation/watchlist/watchlist_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class WatchlistScreen extends StatelessWidget {
  const WatchlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WatchlistCubit()..getWatchlist(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: 20.hPad,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                20.hBox,
                const AppText('Watchlist', size: 24, weight: .w700),
                6.hBox,
                const AppText(
                  'Keep track of your favourite cryptocurrencies',
                  size: 12,
                  color: AppColors.secondaryText,
                ),
                24.hBox,
                Expanded(
                  child: BlocBuilder<WatchlistCubit, WatchlistState>(
                    builder: (context, state) {
                      if (state.isLoading && state.coins.isEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGreen,
                          ),
                        );
                      }

                      if (state.error.isNotEmpty && state.coins.isEmpty) {
                        return WatchlistError(
                          message: state.error,
                          onRetry: () {
                            context.read<WatchlistCubit>().getWatchlist();
                          },
                        );
                      }

                      if (state.coins.isEmpty) {
                        return WatchlistEmpty(
                          onRefresh: () {
                            context.read<WatchlistCubit>().getWatchlist();
                          },
                        );
                      }

                      return RefreshIndicator(
                        color: AppColors.primaryGreen,
                        backgroundColor: AppColors.cardBackground,
                        onRefresh: () {
                          return context.read<WatchlistCubit>().getWatchlist();
                        },
                        child: ListView.separated(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: state.coins.length,
                          separatorBuilder: (_, _) => const Divider(
                            color: AppColors.divider,
                            height: 1,
                          ),
                          itemBuilder: (context, index) {
                            final coin = state.coins[index];
                            final coinId = coin.id ?? '';

                            return MarketsCoinItem(
                              coin: coin,
                              isWatchlisted: true,
                              onTap: () async {
                                await open(
                                  CoinDetailsScreen(
                                    coinId: coinId,
                                    isWatchlisted: true,
                                  ),
                                );

                                // ignore: use_build_context_synchronously
                                await context
                                    .read<WatchlistCubit>()
                                    .getWatchlist();
                              },
                              onWatchlistTap: coinId.isEmpty
                                  ? null
                                  : () {
                                      context
                                          .read<WatchlistCubit>()
                                          .removeFromWatchlist(coinId);
                                    },
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
