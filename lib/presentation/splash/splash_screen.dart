import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/presentation/splash/splash_cubit.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => SplashCubit(),
      child: Scaffold(
        body: Container(
          width: .infinity,
          height: .infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: .topLeft,
              end: .bottomRight,
              colors: [
                AppColors.background,
                Color(0xFF071C28),
                AppColors.background,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisSize: .min,
              children: [
                Container(
                  width: 104,
                  height: 104,
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: 26.bRad,
                    border: .all(
                      color: AppColors.primaryGreen.withValues(alpha: 0.2),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryGreen.withValues(alpha: 0.12),
                        blurRadius: 35,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  padding: 15.aPad,
                  child: Image.asset(
                    'assets/images/app_icon.png',
                    fit: .contain,
                  ),
                ),
                22.hBox,
                const AppText(
                  'CryptoVista',
                  size: 27,
                  weight: .w800,
                  letterSpacing: 1.2,
                  color: AppColors.primaryText,
                ),
                8.hBox,
                const AppText(
                  'Explore the crypto market',
                  size: 12,
                  letterSpacing: 0.6,
                  color: AppColors.secondaryText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
