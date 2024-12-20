import 'package:flutter/material.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';

class RecipiesPage extends StatelessWidget {
  const RecipiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Mes recettes'),
      ),
    );
  }
}
