import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:material_ui/material_ui.dart';

class CoinDetailsLogo extends StatelessWidget {
  const CoinDetailsLogo({super.key, this.image});

  final String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: const BoxDecoration(
        color: AppColors.cardBackground,
        shape: .circle,
      ),
      clipBehavior: .antiAlias,
      child: image != null && image!.isNotEmpty
          ? Image.network(
              image!,
              fit: .cover,
              errorBuilder: (_, _, _) => const Icon(
                Icons.currency_bitcoin_rounded,
                color: AppColors.secondaryText,
              ),
            )
          : const Icon(
              Icons.currency_bitcoin_rounded,
              color: AppColors.secondaryText,
            ),
    );
  }
}
