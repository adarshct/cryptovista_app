import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/data/models/coin_details_model.dart';
import 'package:cryptovista_app/presentation/coin_details/coin_details_cubit.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/coin_details_header.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/coin_details_overview.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/market_statistics.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/price_chart_section.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class CoinDetailsScreen extends StatelessWidget {
  const CoinDetailsScreen({
    super.key,
    required this.coinId,
    required this.isWatchlisted,
  });

  final String coinId;
  final bool isWatchlisted;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoinDetailsCubit()
        ..setWatchlistStatus(isWatchlisted)
        ..getCoinDetails(coinId),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<CoinDetailsCubit, CoinDetailsState>(
            builder: (context, state) {
              final cubit = context.read<CoinDetailsCubit>();

              if (state.isLoading && state.coin == null) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryGreen,
                  ),
                );
              }

              if (state.error.isNotEmpty && state.coin == null) {
                return _ErrorView(
                  message: state.error,
                  onRetry: () => cubit.getCoinDetails(coinId),
                );
              }

              final coin = state.coin;

              if (coin == null) {
                return const Center(
                  child: AppText(
                    'No coin details available',
                    color: AppColors.secondaryText,
                  ),
                );
              }

              return SingleChildScrollView(
                padding: 16.aPad,
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    const CoinDetailsHeader(),
                    28.hBox,
                    CoinDetailsOverview(
                      coin: coin,
                      isWatchlisted: state.isWatchlisted,
                      isWatchlistUpdating: state.isWatchlistUpdating,
                      onWatchlistTap: cubit.toggleWatchlist,
                    ),
                    28.hBox,
                    PriceChartSection(state: state),
                    28.hBox,
                    MarketStatistics(coin: coin),
                    if (coin.description.isNotEmpty) ...[
                      28.hBox,
                      _CoinDescription(coin: coin),
                    ],
                    30.hBox,
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _CoinDescription extends StatelessWidget {
  const _CoinDescription({required this.coin});

  final CoinDetailsModel coin;

  @override
  Widget build(BuildContext context) {
    final description = coin.description
        .replaceAll(RegExp(r'<[^>]*>'), '')
        .replaceAll('&amp;', '&')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&quot;', '"')
        .replaceAll('&#39;', "'");

    return Column(
      crossAxisAlignment: .start,
      children: [
        const AppText('About this coin', size: 16, weight: .w700),
        12.hBox,
        AppText(description, size: 12, color: AppColors.secondaryText),
      ],
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: 24.aPad,
        child: Column(
          mainAxisSize: .min,
          children: [
            const Icon(
              Icons.cloud_off_rounded,
              color: AppColors.secondaryText,
              size: 40,
            ),
            16.hBox,
            AppText(
              message,
              size: 13,
              color: AppColors.secondaryText,
              align: .center,
            ),
            20.hBox,
            ElevatedButton(onPressed: onRetry, child: const AppText('Retry')),
          ],
        ),
      ),
    );
  }
}
