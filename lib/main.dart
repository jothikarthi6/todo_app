import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/models/task_model.g.dart' show TaskModelAdapter;
import 'firebase_options.dart';
import 'models/task_model.dart';
import 'screens/splash_screen.dart';
import 'theme/app_theme.dart';

Future<FirebaseApp> _initFirebase() async {
  // If native side already configured Firebase, just return it.
  try {
    return Firebase.app();
  } catch (_) {
    // No default app yet — continue to initialize.
  }

  try {
    return await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } on FirebaseException catch (e) {
    // Handles hot-restart or native auto-init where default app already exists
    if (e.code == 'duplicate-app') {
      return Firebase.app();
    }
    rethrow;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Init Hive
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());

  await _initFirebase();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: AppTheme.theme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
