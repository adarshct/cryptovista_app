import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

class WatchlistEmpty extends StatelessWidget {
  const WatchlistEmpty({super.key, required this.onRefresh});

  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.primaryGreen,
      onRefresh: () async => onRefresh(),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 300,
            child: Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  const Icon(
                    Icons.star_border_rounded,
                    size: 54,
                    color: AppColors.mutedText,
                  ),
                  16.hBox,
                  const AppText(
                    'Your watchlist is empty',
                    size: 16,
                    weight: .w600,
                  ),
                  8.hBox,
                  const AppText(
                    'Add your favourite coins from the Markets screen.',
                    size: 12,
                    color: AppColors.secondaryText,
                    align: .center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
