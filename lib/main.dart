import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hoodhub/routes/app_router.dart';
import 'package:hoodhub/ui/theme/app_theme.dart';

Future<void> main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(
     ProviderScope(
      child: HoodHubApp(),
    ),
  );
}

class HoodHubApp extends StatelessWidget {
  final AppRouter _appRouter = AppRouter();

  HoodHubApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'HoodHub',
      theme: AppTheme.lightTheme, // Use the AppTheme class here
      debugShowCheckedModeBanner: false,
      routerDelegate: _appRouter.routerDelegate,
      routeInformationParser: _appRouter.routeInformationParser,
      routeInformationProvider: _appRouter.routeInformationProvider,
    );
  }
}
