import 'package:cryptovista_app/presentation/landing/landing_cubit.dart';
import 'package:cryptovista_app/presentation/landing/widgets/app_bottom_navigation_bar.dart';
import 'package:cryptovista_app/presentation/markets/markets_screen.dart';
import 'package:cryptovista_app/presentation/stats/stats_screen.dart';
import 'package:cryptovista_app/presentation/watchlist/watchlist_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class LandingScreen extends StatelessWidget {
  const new({super.key});

  final _pages = const [MarketsScreen(), WatchlistScreen(), StatsScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LandingCubit(),
      child: BlocBuilder<LandingCubit, LandingState>(
        builder: (context, state) {
          final cubit = context.read<LandingCubit>();

          return Scaffold(
            body: _pages[state.currentIndex],
            bottomNavigationBar: AppBottomNavigationBar(
              currentIndex: state.currentIndex,
              onTap: (index) {
                cubit.updateIndex(index);
              },
            ),
          );
        },
      ),
    );
  }
}
