import 'package:cryptovista_app/data/models/global_market_stats_model.dart';
import 'package:cryptovista_app/data/repositories/stats_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  StatsCubit() : super(const StatsState());

  Future<void> getGlobalMarketStats() async {
    safeEmit(state.copyWith(isLoading: true, error: ''));

    try {
      final stats = await StatsRepository.getGlobalMarketStats();

      if (stats == null) {
        safeEmit(
          state.copyWith(
            isLoading: false,
            error: 'Unable to load market statistics.',
          ),
        );
        return;
      }

      safeEmit(state.copyWith(stats: stats, isLoading: false));
    } catch (_) {
      safeEmit(
        state.copyWith(
          isLoading: false,
          error: 'Unable to load market statistics. Please try again.',
        ),
      );
    }
  }

  void safeEmit(StatsState newState) {
    if (!isClosed) emit(newState);
  }
}
