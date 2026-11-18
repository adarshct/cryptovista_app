import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:cryptovista_app/presentation/landing/landing_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashState()) {
    init();
  }

  void init() {
    Future.delayed(const Duration(seconds: 3), () {
      openAsNewPage(const LandingScreen());
    });
  }
}
