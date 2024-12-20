import 'package:flutter/material.dart';
import 'package:muscle_meals/models/routes.dart';
import 'package:muscle_meals/style/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Muscle Meals',
      theme: AppTheme.theme,
      initialRoute: RoutesGenerator.homePage,
      onGenerateRoute: RoutesGenerator.generateRoute,
    );
  }
}
