import 'package:flutter_bloc/flutter_bloc.dart';

part 'landing_state.dart';

class LandingCubit extends Cubit<LandingState> {
  LandingCubit() : super(LandingState());

  void safeEmit(LandingState state) {
    if (!isClosed) emit(state);
  }

  void updateIndex(int index) {
    safeEmit(state.copyWith(currentIndex: index));
  }
}
