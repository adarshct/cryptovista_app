import 'package:cryptovista_app/core/theme/app_colors.dart';
import 'package:cryptovista_app/core/utils/page_navigator.dart';
import 'package:cryptovista_app/presentation/splash/splash_screen.dart';
import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.light, // Android: white icons
  //     statusBarBrightness: Brightness.dark, // iOS: white icons
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CryptoVista',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: AppColors.background),
      navigatorKey: NavigationService.navigatorKey,
      navigatorObservers: [routeObserver],
      builder: (context, child) {
        return SafeArea(
          bottom: true,
          top: false,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            child: child!,
          ),
        );
      },
      home: const SplashScreen(),
    );
  }
}
