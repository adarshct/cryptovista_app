part of 'landing_cubit.dart';

final class LandingState {
  final int currentIndex;

  LandingState({this.currentIndex = 0});

  LandingState copyWith({int? currentIndex}) {
    return LandingState(currentIndex: currentIndex ?? this.currentIndex);
  }
}
