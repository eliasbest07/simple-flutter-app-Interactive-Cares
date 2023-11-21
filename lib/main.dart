import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';


import 'firebase_options.dart';
import 'config/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Only portrait mode to ensure responsivity
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
      title: 'Simple Flutter App Interactive Cares',
      theme: AppTheme().getTheme(),
    );
  }
}
