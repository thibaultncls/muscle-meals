import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muscle_meals/models/bloc/navigation/navigation_bloc.dart';
import 'package:muscle_meals/routes/feed_page.dart';
import 'package:muscle_meals/routes/profil_page.dart';
import 'package:muscle_meals/routes/recipies_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
              bottomNavigationBar: BottomNavigationBar(
                  items: const [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.person_outlined), label: 'Profil'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home_outlined), label: 'Recettes'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.kitchen_outlined),
                        label: 'Mes recettes')
                  ],
                  currentIndex: state.index,
                  onTap: (index) {
                    context.read<NavigationBloc>().add(NavigationEvent(index));
                  }),
              body: pages[state.index]);
        },
      ),
    );
  }

  final pages = const [ProfilPage(), FeedPage(), RecipiesPage()];
}
