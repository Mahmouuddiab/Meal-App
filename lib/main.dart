import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_app/core/locator/service_locator.dart';
import 'package:meal_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:meal_app/features/auth/presentation/screens/register.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependices();
  runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => serviceLocator<AuthBloc>(),)
        ],
          child: const MyApp()
      )
  );
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

