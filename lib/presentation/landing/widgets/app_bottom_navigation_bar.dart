import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavigationItem> _items = [
    _NavigationItem(
      label: 'Markets',
      activeIcon: Icons.bar_chart_rounded,
      inactiveIcon: Icons.bar_chart_outlined,
    ),
    _NavigationItem(
      label: 'Watchlist',
      activeIcon: Icons.star_rounded,
      inactiveIcon: Icons.star_border_rounded,
    ),
    _NavigationItem(
      label: 'Stats',
      activeIcon: Icons.pie_chart_rounded,
      inactiveIcon: Icons.pie_chart_outline_rounded,
    ),
    // _NavigationItem(
    //   label: 'More',
    //   activeIcon: Icons.more_horiz_rounded,
    //   inactiveIcon: Icons.more_horiz_rounded,
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.secondaryBackground,
        border: Border(top: BorderSide(color: AppColors.divider, width: 0.7)),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 65,
          child: Row(
            children: List.generate(_items.length, (index) {
              final item = _items[index];
              final isSelected = currentIndex == index;

              return Expanded(
                child: InkWell(
                  onTap: () => onTap(index),
                  splashColor: AppColors.primaryGreen.withValues(alpha: 0.08),
                  highlightColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Icon(
                        isSelected ? item.activeIcon : item.inactiveIcon,
                        size: 23,
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.mutedText,
                      ),
                      4.hBox,
                      AppText(
                        item.label,
                        size: 10,
                        weight: isSelected ? .w600 : .w500,
                        color: isSelected
                            ? AppColors.primaryGreen
                            : AppColors.secondaryText,
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem {
  final String label;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const _NavigationItem({
    required this.label,
    required this.activeIcon,
    required this.inactiveIcon,
  });
}
