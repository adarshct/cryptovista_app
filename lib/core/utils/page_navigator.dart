import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';

Route<T> _buildRoute<T extends StateStreamableSource<Object?>>(
  Widget page, {
  required BuildContext context,
}) {
  return PageRouteBuilder<T>(
    opaque: true,
    barrierColor: AppColors.background,
    transitionDuration: const Duration(milliseconds: 250),
    reverseTransitionDuration: const Duration(milliseconds: 200),
    pageBuilder: (routeContext, animation, secondaryAnimation) {
      try {
        final bloc = context.read<T>();

        return BlocProvider<T>.value(value: bloc, child: page);
      } catch (_) {
        return page;
      }
    },
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
        child: child,
      );
    },
  );
}

Future open<T extends StateStreamableSource<Object?>>(
  Widget page, {
  BuildContext? context,
}) {
  final currentContext = context ?? NavigationService.context!;

  return Navigator.push(
    currentContext,
    _buildRoute<T>(page, context: currentContext),
  );
}

Future openClosingCurrent<T extends StateStreamableSource<Object?>>(
  Widget page, {
  BuildContext? context,
}) {
  final currentContext = context ?? NavigationService.context!;

  return Navigator.pushReplacement(
    currentContext,
    _buildRoute<T>(page, context: currentContext),
  );
}

Future openAsNewPage(Widget page, {BuildContext? context}) {
  return Navigator.pushAndRemoveUntil(
    context ?? NavigationService.context!,
    PageRouteBuilder(
      opaque: true,
      barrierColor: AppColors.background,
      transitionDuration: const Duration(milliseconds: 250),
      reverseTransitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, animation, secondaryAnimation) => page,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
          child: child,
        );
      },
    ),
    (route) => false,
  );
}

void closePage({dynamic result, BuildContext? context}) {
  Navigator.pop(context ?? NavigationService.context!, result);
}

void closeDialog({dynamic result, BuildContext? context}) {
  Navigator.of(
    context ?? NavigationService.context!,
    rootNavigator: true,
  ).pop(result);
}

abstract class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static BuildContext? get context => navigatorKey.currentContext;
}
