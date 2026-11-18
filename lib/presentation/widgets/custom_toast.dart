import 'package:cryptovista_app/core/extensions/number_extensions.dart';
import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/device.dart';
import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:cryptovista_app/presentation/widgets/app_text.dart';
import 'package:material_ui/material_ui.dart';

abstract class CustomToast {
  static void toast(
    String? message, {
    ToastType type = ToastType.info,
    BuildContext? context,
  }) {
    late OverlayEntry overlayEntry;

    final animationController = AnimationController(
      vsync: Navigator.of(context ?? NavigationService.context!),
      duration: const Duration(milliseconds: 350),
    );

    final offsetAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    final opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: animationController, curve: Curves.easeOut),
    );

    overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent,
            child: SafeArea(
              child: FadeTransition(
                opacity: opacityAnimation,
                child: SlideTransition(
                  position: offsetAnimation,
                  child: Center(
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: 100,
                        maxWidth: Device.width * 0.8,
                      ),
                      padding: 16.hPad + 10.vPad,
                      decoration: BoxDecoration(
                        color: type == ToastType.success
                            ? AppColors.positive
                            : type == ToastType.error
                            ? AppColors.negative
                            : AppColors.gold,
                        borderRadius: 30.bRad,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: AppText(
                              message ?? "Something went wrong",
                              weight: .w500,
                              color: Colors.white,
                              size: 13,
                              maxLines: 20,
                            ),
                          ),
                          8.wBox,
                          Icon(
                            type == ToastType.success
                                ? Icons.verified
                                : type == ToastType.error
                                ? Icons.cancel
                                : Icons.error,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    final overlayState = NavigationService.navigatorKey.currentState?.overlay;

    if (overlayState == null) return;

    overlayState.insert(overlayEntry);
    animationController.forward();

    Future.delayed(const Duration(seconds: 2), () async {
      await animationController.reverse();
      overlayEntry.remove();
      animationController.dispose();
    });
  }

  static void success(String? message, {BuildContext? context}) {
    toast(message, type: ToastType.success, context: context);
  }

  static void error(String? message, {BuildContext? context}) {
    toast(message, type: ToastType.error, context: context);
  }
}

enum ToastType { success, error, info }
