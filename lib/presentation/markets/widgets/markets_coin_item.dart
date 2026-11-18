import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/data/models/market_coin_model.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class MarketsCoinItem extends StatelessWidget {
  const MarketsCoinItem({
    super.key,
    required this.coin,
    this.onTap,
    this.onWatchlistTap,
    this.isWatchlisted = false,
  });

  final MarketCoinModel coin;
  final VoidCallback? onTap;
  final VoidCallback? onWatchlistTap;
  final bool isWatchlisted;

  @override
  Widget build(BuildContext context) {
    final price = coin.currentPrice;
    final priceChange = coin.priceChangePercentage24h;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: 12.vPad,
        child: Row(
          children: [
            // Coin logo
            Container(
              height: 42,
              width: 42,
              decoration: BoxDecoration(
                shape: .circle,
                color: AppColors.cardBackground,
                image: coin.image != null && coin.image!.isNotEmpty
                    ? DecorationImage(
                        image: NetworkImage(coin.image!),
                        fit: .cover,
                      )
                    : null,
              ),
              child: coin.image == null || coin.image!.isEmpty
                  ? const Icon(
                      Icons.currency_bitcoin_rounded,
                      color: AppColors.secondaryText,
                      size: 22,
                    )
                  : null,
            ),

            12.wBox,

            // Coin name and symbol
            Expanded(
              child: Column(
                crossAxisAlignment: .start,
                children: [
                  AppText(coin.name ?? '', size: 13, weight: .w600),
                  4.hBox,
                  AppText(
                    (coin.symbol ?? '').toUpperCase(),
                    size: 11,
                    color: AppColors.secondaryText,
                  ),
                ],
              ),
            ),

            // Price and percentage change
            Column(
              crossAxisAlignment: .end,
              children: [
                AppText(
                  price != null ? '\$${price.toStringAsFixed(2)}' : '--',
                  size: 13,
                  weight: .w600,
                ),
                4.hBox,
                if (priceChange != null)
                  AppText(
                    '${priceChange.isNegative ? "▼" : "▲"} '
                    '${priceChange.abs().toStringAsFixed(2)}%',
                    size: 11,
                    weight: .w600,
                    color: priceChange.isNegative
                        ? AppColors.negative
                        : AppColors.positive,
                  )
                else
                  const AppText('--', size: 11, color: AppColors.secondaryText),
              ],
            ),

            10.wBox,

            // Watchlist button
            GestureDetector(
              behavior: .opaque,
              onTap: onWatchlistTap,
              child: Padding(
                padding: 4.aPad,
                child: Icon(
                  isWatchlisted
                      ? Icons.star_rounded
                      : Icons.star_border_rounded,
                  color: isWatchlisted
                      ? AppColors.gold
                      : AppColors.secondaryText,
                  size: 21,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
