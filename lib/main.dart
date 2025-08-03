import 'package:flutter/material.dart';
import 'package:meal_app/features/auth/presentation/screens/register.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
      url: "https://sayzgcursvgjkpbrcotm.supabase.co",
      anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNheXpnY3Vyc3ZnamtwYnJjb3RtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQxOTkwMTgsImV4cCI6MjA2OTc3NTAxOH0.7UVImAs1t2ftXQ7o14_lYnxWuLLDyVMkaL9vRIJPSeg");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Register(),
    );
  }
}

