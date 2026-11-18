import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class WatchlistError extends StatelessWidget {
  const WatchlistError({
    super.key,
    required this.message,
    required this.onRetry,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          const Icon(
            Icons.cloud_off_rounded,
            size: 44,
            color: AppColors.mutedText,
          ),
          16.hBox,
          AppText(
            message,
            size: 13,
            color: AppColors.secondaryText,
            align: .center,
          ),
          20.hBox,
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryGreen,
              foregroundColor: AppColors.background,
            ),
            child: const AppText('Try Again'),
          ),
        ],
      ),
    );
  }
}
