import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/utils.dart';
import 'package:cryptovista_app/data/models/coin_details_model.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class MarketStatistics extends StatelessWidget {
  const MarketStatistics({super.key, required this.coin});

  final CoinDetailsModel coin;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const AppText('Market Statistics', size: 16, weight: .w700),
        16.hBox,
        Container(
          padding: 16.aPad,
          decoration: BoxDecoration(
            color: AppColors.secondaryBackground,
            borderRadius: 14.bRad,
          ),
          child: Column(
            children: [
              _StatRow(
                label: 'Market Cap',
                value: _formatCompact(coin.marketCap),
              ),
              _statDivider(),
              _StatRow(
                label: '24h Trading Volume',
                value: _formatCompact(coin.totalVolume),
              ),
              _statDivider(),
              _StatRow(
                label: 'Circulating Supply',
                value: _formatSupply(coin.circulatingSupply),
              ),
              _statDivider(),
              _StatRow(
                label: 'Total Supply',
                value: _formatSupply(coin.totalSupply),
              ),
              _statDivider(),
              _StatRow(
                label: 'Max Supply',
                value: _formatSupply(coin.maxSupply),
              ),
              _statDivider(),
              _StatRow(
                label: 'All-Time High',
                value: Utils.formatPrice(coin.ath),
              ),
              _statDivider(),
              _StatRow(
                label: 'All-Time Low',
                value: Utils.formatPrice(coin.atl),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statDivider() {
    return Padding(
      padding: 12.vPad,
      child: Divider(
        height: 1,
        color: AppColors.divider.withValues(alpha: 0.7),
      ),
    );
  }

  String _formatCompact(double? value) {
    if (value == null) return '--';

    final absolute = value.abs();

    if (absolute >= 1e12) {
      return '\$${(value / 1e12).toStringAsFixed(2)}T';
    }

    if (absolute >= 1e9) {
      return '\$${(value / 1e9).toStringAsFixed(2)}B';
    }

    if (absolute >= 1e6) {
      return '\$${(value / 1e6).toStringAsFixed(2)}M';
    }

    if (absolute >= 1e3) {
      return '\$${(value / 1e3).toStringAsFixed(2)}K';
    }

    return '\$${Utils.formatNumber(value)}';
  }

  String _formatSupply(double? value) {
    if (value == null) return '--';

    if (value >= 1e12) {
      return '${(value / 1e12).toStringAsFixed(2)}T';
    }

    if (value >= 1e9) {
      return '${(value / 1e9).toStringAsFixed(2)}B';
    }

    if (value >= 1e6) {
      return '${(value / 1e6).toStringAsFixed(2)}M';
    }

    if (value >= 1e3) {
      return '${(value / 1e3).toStringAsFixed(2)}K';
    }

    return Utils.formatNumber(value);
  }
}

class _StatRow extends StatelessWidget {
  const _StatRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppText(label, size: 12, color: AppColors.secondaryText),
        ),
        AppText(value, size: 12, weight: .w600),
      ],
    );
  }
}
