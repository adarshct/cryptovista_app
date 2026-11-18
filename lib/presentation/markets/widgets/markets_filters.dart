import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/markets/markets_cubit.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class MarketsFilters extends StatelessWidget {
  const MarketsFilters({
    super.key,
    required this.selectedFilterIndex,
    required this.onFilterSelected,
  });

  final int selectedFilterIndex;
  final Function(int) onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        _buildFilterButton(selectedFilterIndex == 0, 'All', 0),
        _buildFilterButton(selectedFilterIndex == 1, 'Top 100', 1),
        _buildFilterButton(selectedFilterIndex == 2, 'Gainers', 2),
        _buildFilterButton(selectedFilterIndex == 3, 'Losers', 3),
      ],
    );
  }

  Widget _buildFilterButton(bool isSelected, String label, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterSelected(index),
        child: Container(
          padding: 14.hPad + 8.vPad,
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.primaryGreen
                : AppColors.cardBackground,
            borderRadius: 30.bRad,
            border: .all(
              color: isSelected ? AppColors.primaryGreen : AppColors.divider,
            ),
          ),
          child: Center(
            child: AppText(
              label,
              size: 11,
              weight: .w600,
              color: isSelected
                  ? AppColors.background
                  : AppColors.secondaryText,
            ),
          ),
        ),
      ),
    );
  }
}

// MARKETS SORTING

class MarketsSorting extends StatelessWidget {
  const MarketsSorting({
    super.key,
    required this.selectedSortType,
    required this.isSortAscending,
    required this.onSortChanged,
    required this.onDirectionChanged,
  });

  final MarketSortType selectedSortType;
  final bool isSortAscending;
  final ValueChanged<MarketSortType> onSortChanged;
  final VoidCallback onDirectionChanged;

  String _labelFor(MarketSortType type) {
    switch (type) {
      case .marketCap:
        return 'Market Cap';
      case .price:
        return 'Price';
      case .change24h:
        return '24h Change';
      case .volume:
        return 'Volume';
      case .name:
        return 'Name';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Row(
          children: [
            const AppText(
              'Sort by',
              size: 12,
              color: AppColors.secondaryText,
              weight: .w500,
            ),
            const Spacer(),
            GestureDetector(
              onTap: onDirectionChanged,
              child: Container(
                padding: 9.aPad,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: 10.bRad,
                  border: .all(color: AppColors.divider),
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    Icon(
                      isSortAscending
                          ? Icons.arrow_upward_rounded
                          : Icons.arrow_downward_rounded,
                      size: 15,
                      color: AppColors.primaryGreen,
                    ),
                    5.wBox,
                    AppText(
                      isSortAscending ? 'Ascending' : 'Descending',
                      size: 10,
                      color: AppColors.primaryText,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        10.hBox,
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: MarketSortType.values.map((type) {
            final isSelected = selectedSortType == type;

            return GestureDetector(
              onTap: () => onSortChanged(type),
              child: Container(
                padding: 12.hPad + 9.vPad,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.primaryGreen.withValues(alpha: 0.12)
                      : AppColors.cardBackground,
                  borderRadius: 20.bRad,
                  border: .all(
                    color: isSelected
                        ? AppColors.primaryGreen
                        : AppColors.divider,
                  ),
                ),
                child: Row(
                  mainAxisSize: .min,
                  children: [
                    AppText(
                      _labelFor(type),
                      size: 10,
                      weight: .w600,
                      color: isSelected
                          ? AppColors.primaryGreen
                          : AppColors.secondaryText,
                    ),
                    if (isSelected) ...[
                      5.wBox,
                      const Icon(
                        Icons.check,
                        size: 13,
                        color: AppColors.primaryGreen,
                      ),
                    ],
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
