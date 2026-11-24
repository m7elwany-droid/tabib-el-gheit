import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'theme/app_theme.dart';
import 'screens/main_nav_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TabibElGheitApp());
}

class TabibElGheitApp extends StatelessWidget {
  const TabibElGheitApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طبيب الغيط',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      // دعم اللغة العربية والاتجاه من اليمين لليسار (RTL) بشكل أصيل
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('ar'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: const MainNavScreen(),
    );
  }
}
