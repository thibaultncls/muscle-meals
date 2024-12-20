import 'package:flutter/material.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';

class ProfilPage extends StatelessWidget {
  const ProfilPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Profil'),
        leading: IconButton(
            onPressed: () => Navigator.pushNamed(context, '/settingsPage'),
            icon: const Icon(Icons.settings_outlined)),
      ),
    );
  }
}
