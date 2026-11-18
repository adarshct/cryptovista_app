import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/utils.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class StatsMarketCapCard extends StatelessWidget {
  const StatsMarketCapCard({
    super.key,
    required this.marketCap,
    required this.change,
  });

  final double? marketCap;
  final double? change;

  @override
  Widget build(BuildContext context) {
    final isPositive = (change ?? 0) >= 0;

    return Container(
      width: .infinity,
      padding: 18.aPad,
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: 16.bRad,
        border: .all(color: AppColors.divider),
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Row(
            children: [
              Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen.withValues(alpha: 0.12),
                  borderRadius: 10.bRad,
                ),
                child: const Icon(
                  Icons.public_rounded,
                  color: AppColors.primaryGreen,
                  size: 20,
                ),
              ),
              10.wBox,
              const AppText(
                'Total Market Capitalization',
                size: 12,
                color: AppColors.secondaryText,
              ),
            ],
          ),
          20.hBox,
          AppText(Utils.formatCurrency(marketCap), size: 27, weight: .w700),
          10.hBox,
          Row(
            children: [
              Icon(
                isPositive
                    ? Icons.trending_up_rounded
                    : Icons.trending_down_rounded,
                size: 16,
                color: isPositive ? AppColors.positive : AppColors.negative,
              ),
              5.wBox,
              AppText(
                '${isPositive ? '+' : ''}${(change ?? 0).toStringAsFixed(2)}%',
                size: 12,
                weight: .w600,
                color: isPositive ? AppColors.positive : AppColors.negative,
              ),
              5.wBox,
              const AppText(
                'in the last 24 hours',
                size: 11,
                color: AppColors.secondaryText,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
