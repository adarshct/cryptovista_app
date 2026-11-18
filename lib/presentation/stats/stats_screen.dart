import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/stats/stats_cubit.dart';
import 'package:cryptovista_app/presentation/stats/widgets/stats_content.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => StatsCubit()..getGlobalMarketStats(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Padding(
            padding: 20.hPad,
            child: Column(
              crossAxisAlignment: .start,
              children: [
                20.hBox,
                const AppText('Market Stats', size: 24, weight: .w700),
                6.hBox,
                const AppText(
                  'Explore the global cryptocurrency market',
                  size: 12,
                  color: AppColors.secondaryText,
                ),
                24.hBox,
                Expanded(
                  child: BlocBuilder<StatsCubit, StatsState>(
                    builder: (context, state) {
                      if (state.isLoading && state.stats == null) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryGreen,
                          ),
                        );
                      }

                      if (state.error.isNotEmpty && state.stats == null) {
                        return _StatsError(
                          message: state.error,
                          onRetry: () {
                            context.read<StatsCubit>().getGlobalMarketStats();
                          },
                        );
                      }

                      if (state.stats == null) {
                        return const Center(
                          child: AppText(
                            'No market statistics available.',
                            color: AppColors.secondaryText,
                          ),
                        );
                      }

                      return RefreshIndicator(
                        color: AppColors.primaryGreen,
                        backgroundColor: AppColors.cardBackground,
                        onRefresh: () {
                          return context
                              .read<StatsCubit>()
                              .getGlobalMarketStats();
                        },
                        child: StatsContent(stats: state.stats!),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StatsError extends StatelessWidget {
  const _StatsError({required this.message, required this.onRetry});

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
