import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/utils.dart';
import 'package:cryptovista_app/data/models/global_market_stats_model.dart';
import 'package:cryptovista_app/presentation/stats/widgets/stats_market_cap_card.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class StatsContent extends StatelessWidget {
  const StatsContent({super.key, required this.stats});

  final GlobalMarketStatsModel stats;

  @override
  Widget build(BuildContext context) {
    final marketChange = stats.marketCapChangePercentage24h ?? 0;
    final isPositive = marketChange >= 0;

    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const _SectionTitle(title: 'Global Market Overview'),
        14.hBox,
        StatsMarketCapCard(
          marketCap: stats.totalMarketCap,
          change: stats.marketCapChangePercentage24h,
        ),
        12.hBox,
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: '24H Trading Volume',
                value: Utils.formatCurrency(stats.totalVolume),
                icon: Icons.bar_chart_rounded,
                iconColor: AppColors.accentTeal,
              ),
            ),
            12.wBox,
            Expanded(
              child: _StatCard(
                title: 'Market Cap Change',
                value:
                    '${isPositive ? '+' : ''}${marketChange.toStringAsFixed(2)}%',
                icon: isPositive
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                iconColor: isPositive ? AppColors.positive : AppColors.negative,
                valueColor: isPositive
                    ? AppColors.positive
                    : AppColors.negative,
              ),
            ),
          ],
        ),
        28.hBox,
        const _SectionTitle(title: 'Market Dominance'),
        14.hBox,
        _DominanceCard(
          title: 'Bitcoin',
          symbol: 'BTC',
          percentage: stats.btcDominance,
          color: AppColors.gold,
        ),
        12.hBox,
        _DominanceCard(
          title: 'Ethereum',
          symbol: 'ETH',
          percentage: stats.ethDominance,
          color: AppColors.accentTeal,
        ),
        28.hBox,
        const _SectionTitle(title: 'Market Activity'),
        14.hBox,
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'Cryptocurrencies',
                value: _formatCount(stats.activeCryptocurrencies),
                icon: Icons.currency_bitcoin_rounded,
                iconColor: AppColors.gold,
              ),
            ),
            12.wBox,
            Expanded(
              child: _StatCard(
                title: 'Active Exchanges',
                value: _formatCount(stats.activeExchanges),
                icon: Icons.swap_horiz_rounded,
                iconColor: AppColors.accentTeal,
              ),
            ),
          ],
        ),
        12.hBox,
        _StatCard(
          title: 'Total Markets',
          value: _formatCount(stats.activeMarkets),
          icon: Icons.public_rounded,
          iconColor: AppColors.primaryGreen,
          fullWidth: true,
        ),
        24.hBox,
        const Center(
          child: AppText(
            'Data provided by CoinGecko',
            size: 10,
            color: AppColors.mutedText,
          ),
        ),
        20.hBox,
      ],
    );
  }

  String _formatCount(int? value) {
    if (value == null) return '--';

    if (value >= 1000000) {
      return '${(value / 1000000).toStringAsFixed(2)}M';
    }

    if (value >= 1000) {
      return '${(value / 1000).toStringAsFixed(1)}K';
    }

    return value.toString();
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return AppText(title, size: 15, weight: FontWeight.w600);
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    this.valueColor = AppColors.primaryText,
    this.fullWidth = false,
  });

  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final Color valueColor;
  final bool fullWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: fullWidth ? .infinity : null,
      padding: 16.aPad,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: 14.bRad,
        border: .all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Icon(icon, color: iconColor, size: 21),
          16.hBox,
          AppText(value, size: 18, weight: .w700, color: valueColor),
          6.hBox,
          AppText(title, size: 11, color: AppColors.secondaryText),
        ],
      ),
    );
  }
}

class _DominanceCard extends StatelessWidget {
  const _DominanceCard({
    required this.title,
    required this.symbol,
    required this.percentage,
    required this.color,
  });

  final String title;
  final String symbol;
  final double? percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final value = (percentage ?? 0).clamp(0.0, 100.0).toDouble();

    return Container(
      padding: 16.aPad,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: 14.bRad,
        border: .all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 34,
                width: 34,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  shape: .circle,
                ),
                child: Center(
                  child: AppText(
                    symbol.substring(0, 1),
                    size: 15,
                    weight: .w700,
                    color: color,
                  ),
                ),
              ),
              10.wBox,
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    AppText(title, size: 13, weight: .w600),
                    3.hBox,
                    AppText(symbol, size: 10, color: AppColors.secondaryText),
                  ],
                ),
              ),
              AppText(
                '${(percentage ?? 0).toStringAsFixed(2)}%',
                size: 16,
                weight: .w700,
                color: color,
              ),
            ],
          ),
          14.hBox,
          ClipRRect(
            borderRadius: 10.bRad,
            child: LinearProgressIndicator(
              value: value / 100,
              minHeight: 7,
              backgroundColor: AppColors.elevatedCard,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ],
      ),
    );
  }
}
