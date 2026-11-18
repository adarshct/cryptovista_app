import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class MarketsHeader extends StatelessWidget {
  const MarketsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: AppColors.primaryGreen.withValues(alpha: 0.12),
            borderRadius: 13.bRad,
          ),
          child: Center(
            child: Image.asset(
              'assets/images/app_icon.png',
              width: 26,
              height: 26,
            ),
          ),
        ),
        12.wBox,
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            children: [
              const Row(
                children: [
                  AppText('Crypto', size: 19, weight: .w700),
                  AppText(
                    'Vista',
                    size: 19,
                    weight: .w700,
                    color: AppColors.primaryGreen,
                  ),
                ],
              ),
              3.hBox,
              const AppText(
                'Explore crypto markets',
                size: 11,
                color: AppColors.mutedText,
              ),
            ],
          ),
        ),
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: 13.bRad,
            border: .all(color: AppColors.divider),
          ),
          child: Stack(
            alignment: .center,
            children: [
              const Icon(
                Icons.notifications_none_rounded,
                color: AppColors.primaryText,
                size: 23,
              ),
              Positioned(
                top: 9,
                right: 10,
                child: Container(
                  height: 7,
                  width: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryGreen,
                    shape: .circle,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
