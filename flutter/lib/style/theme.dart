import 'package:flutter/material.dart';
import 'package:muscle_meals/style/colors.dart';

class AppTheme {
  static const double _radius = 14;

  static var theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blueOcean),
    dialogTheme: const DialogTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(14)))),
    // ! TextField
    inputDecorationTheme: InputDecorationTheme(
        focusColor: AppColors.blueOcean,
        floatingLabelStyle: const TextStyle(color: AppColors.blueOcean),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(
              width: .1,
            )),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide:
                BorderSide(color: AppColors.secondaryText.withOpacity(.5))),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide:
                BorderSide(color: AppColors.secondaryText.withOpacity(.5))),
        contentPadding: const EdgeInsets.only(left: 14),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(_radius),
            borderSide: const BorderSide(color: Colors.red))),
    primaryColor: AppColors.blueOcean,
    // ! Tabbar
    tabBarTheme: const TabBarTheme(
        indicatorColor: AppColors.blueOcean, labelColor: AppColors.blueOcean),
    scaffoldBackgroundColor: AppColors.clearGrey,
    buttonTheme: const ButtonThemeData(buttonColor: AppColors.emeraldGreen),
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.clearGrey),
    outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
            side: WidgetStatePropertyAll(
                BorderSide(color: AppColors.energicOrange)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))))),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            elevation: WidgetStatePropertyAll(0),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)))),
            backgroundColor: WidgetStatePropertyAll(AppColors.emeraldGreen),
            textStyle: WidgetStatePropertyAll(TextStyle(
                color: AppColors.clearGrey,
                fontWeight: FontWeight.w600,
                fontSize: 16)))),
    useMaterial3: true,
  );

  static const textButtonTheme = TextStyle(
      color: AppColors.clearGrey, fontWeight: FontWeight.w600, fontSize: 16);

  static const textOutlinedButtonTheme = TextStyle(
      color: AppColors.energicOrange,
      fontWeight: FontWeight.w600,
      fontSize: 16);

  static const recipeInputBorder = UnderlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(width: .8));

  static const newRecipeStyle = TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: AppColors.charcoalBlack);
}
