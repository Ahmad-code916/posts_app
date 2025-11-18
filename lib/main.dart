import 'package:application_new/firebase_options.dart';
import 'package:application_new/post_app_screens/splash_screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Supabase.initialize(
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxtc29vdmxkdml2ZGxkcXhjYWl6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjMxNzI3NzMsImV4cCI6MjA3ODc0ODc3M30.yecHqWeFn7BequF2rIk0yQKPK_i890Twlalx1SsIom0',
    url: 'https://lmsoovldvivdldqxcaiz.supabase.co',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
