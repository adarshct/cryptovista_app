import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/utils.dart';
import 'package:cryptovista_app/data/models/coin_details_model.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/coin_details_logo.dart';
import 'package:cryptovista_app/presentation/coin_details/widgets/high_low_item.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class CoinDetailsOverview extends StatelessWidget {
  const CoinDetailsOverview({
    super.key,
    required this.coin,
    required this.isWatchlisted,
    required this.isWatchlistUpdating,
    required this.onWatchlistTap,
  });

  final CoinDetailsModel coin;
  final bool isWatchlisted;
  final bool isWatchlistUpdating;
  final VoidCallback onWatchlistTap;

  @override
  Widget build(BuildContext context) {
    final isPositive = (coin.priceChangePercentage24h ?? 0) >= 0;

    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            CoinDetailsLogo(image: coin.image),
            12.wBox,
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  AppText(coin.name, size: 18, weight: .w700),
                  5.hBox,
                  Row(
                    children: [
                      AppText(
                        coin.symbol.toUpperCase(),
                        size: 12,
                        color: AppColors.secondaryText,
                      ),
                      if (coin.marketCapRank != null) ...[
                        8.wBox,
                        Container(
                          padding: 5.aPad,
                          decoration: BoxDecoration(
                            color: AppColors.cardBackground,
                            borderRadius: 6.bRad,
                          ),
                          child: AppText(
                            'Rank #${coin.marketCapRank}',
                            size: 10,
                            color: AppColors.secondaryText,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: isWatchlistUpdating ? null : onWatchlistTap,
              child: Container(
                padding: 8.aPad,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: 10.bRad,
                ),
                child: isWatchlistUpdating
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.primaryGreen,
                        ),
                      )
                    : Icon(
                        isWatchlisted
                            ? Icons.star_rounded
                            : Icons.star_border_rounded,
                        color: AppColors.gold,
                        size: 25,
                      ),
              ),
            ),
          ],
        ),
        24.hBox,
        AppText(Utils.formatPrice(coin.currentPrice), size: 30, weight: .w700),
        10.hBox,
        Row(
          children: [
            Icon(
              isPositive
                  ? Icons.trending_up_rounded
                  : Icons.trending_down_rounded,
              color: isPositive ? AppColors.positive : AppColors.negative,
              size: 18,
            ),
            5.wBox,
            AppText(
              '${isPositive ? '+' : ''}'
              '${(coin.priceChangePercentage24h ?? 0).toStringAsFixed(2)}%',
              size: 13,
              weight: .w600,
              color: isPositive ? AppColors.positive : AppColors.negative,
            ),
            7.wBox,
            const AppText('24h', size: 12, color: AppColors.secondaryText),
          ],
        ),
        20.hBox,
        Row(
          children: [
            Expanded(
              child: HighLowItem(
                label: '24h High',
                value: Utils.formatPrice(coin.high24h),
                color: AppColors.positive,
              ),
            ),
            Expanded(
              child: HighLowItem(
                label: '24h Low',
                value: Utils.formatPrice(coin.low24h),
                color: AppColors.negative,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
