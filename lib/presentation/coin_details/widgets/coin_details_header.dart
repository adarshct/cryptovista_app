import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class CoinDetailsHeader extends StatelessWidget {
  const CoinDetailsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.primaryText,
            size: 24,
          ),
        ),
        14.wBox,
        const AppText('Coin Details', size: 18, weight: .w700),
        const Spacer(),
        const Icon(
          Icons.more_horiz_rounded,
          color: AppColors.secondaryText,
          size: 24,
        ),
      ],
    );
  }
}
