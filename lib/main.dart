import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/configs/theme/app_theme.dart';
import 'presentation/onBoarding/on_boarding_page.dart';
import 'presentation/rout_page/pages/portfolio/data/portfolio_storage.dart';
import 'presentation/rout_page/pages/root_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: const _AppStartDecider(),
    );
  }
}

class _AppStartDecider extends StatelessWidget {
  const _AppStartDecider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: ProfileStorage.getEmail(),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final email = snapshot.data;
        if (email != null && email.trim().isNotEmpty) {
          return const RootPage();
        }

        
        return const OnBoardingPage();
      },
    );
  }
}
