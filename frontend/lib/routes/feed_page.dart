import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:muscle_meals/models/routes.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle('Recettes'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, RoutesGenerator.newRecipePage),
                icon: const Icon(
                  Icons.add_circle_outline,
                  size: 32,
                )),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Card(
                child: SizedBox(
                  width: width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Poulet façon KFC',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.charcoalBlack,
                              fontSize: 20),
                        ),
                        const Text(
                          'John Doe',
                          style: TextStyle(
                              color: AppColors.secondaryText, fontSize: 13),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              fit: BoxFit.contain,
                              'assets/images/poulet.png',
                              width: width * 0.4,
                              height: width * 0.4,
                            ),
                            const Gap(10),
                            const SizedBox(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Difficulté'),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppColors.energicOrange,
                                      ),
                                      Icon(
                                        Icons.star_outline_outlined,
                                      ),
                                      Icon(
                                        Icons.star_outline_outlined,
                                      )
                                    ],
                                  ),
                                  Gap(10),
                                  Text('Temps de préparation'),
                                  Text(
                                    '30 minutes',
                                    style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 13),
                                  ),
                                  Gap(10),
                                  Text('Calories (100gr)'),
                                  Text(
                                    '170 calories',
                                    style: TextStyle(
                                        color: AppColors.secondaryText,
                                        fontSize: 13),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Table(
                          border: TableBorder.all(
                              color: AppColors.secondaryText.withOpacity(.5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)),
                              width: .5),
                          children: [
                            TableRow(children: [
                              SizedBox(
                                child: Text(
                                  'Protéines',
                                  textAlign: TextAlign.center,
                                ),
                                height: 30,
                              ),
                              Text(
                                'Lipides',
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                'Glucides',
                                textAlign: TextAlign.center,
                              ),
                            ]),
                            TableRow(children: [
                              Text('25 gr',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.secondaryText)),
                              Text(
                                '15 gr',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.secondaryText),
                              ),
                              Text(
                                '10 gr',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 13,
                                    color: AppColors.secondaryText),
                              )
                            ]),
                          ],
                        ),
                        Gap(10),
                        Text(
                            '1 - Coupez les blancs de poulet en gros dés, mettez-les dans un saladier.'),
                        Text(
                          'Voir plus...',
                          style: TextStyle(color: AppColors.blueOcean),
                        ),
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              Icon(Icons.favorite_border_outlined),
                              Gap(30),
                              Icon(Icons.bookmark_add_outlined)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
