import 'dart:ui';
import 'package:flutter/material.dart';
import 'makeup_theme.dart';
import 'splash_screen.dart';

void main() {
  runApp(const GlamShopApp());
}

class GlamShopApp extends StatelessWidget {
  const GlamShopApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: kPrimaryPink,
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'GlamShop',
      debugShowCheckedModeBanner: false,
      scrollBehavior: GlamScrollBehavior(),
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: kLightPink,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: kLightPink,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black87),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryPink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            padding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

/// تفعيل السحب بالماوس / التاتش باد
class GlamScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
    PointerDeviceKind.touch,
    PointerDeviceKind.mouse,
    PointerDeviceKind.trackpad,
    PointerDeviceKind.stylus,
  };
}
