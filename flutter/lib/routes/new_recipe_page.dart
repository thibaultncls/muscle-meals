import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:logger/web.dart';
import 'package:muscle_meals/models/bloc/difficulty/difficulty_bloc.dart';
import 'package:muscle_meals/models/bloc/focus/focus_bloc.dart';
import 'package:muscle_meals/models/bloc/pick_image/pick_image_bloc.dart';
import 'package:muscle_meals/models/bloc/recipe_controllers/recipe_controllers_bloc.dart';
import 'package:muscle_meals/models/bloc/validator/validator_bloc.dart';
import 'package:muscle_meals/models/controller_manager.dart';
import 'package:muscle_meals/models/focus_node_manager.dart';
import 'package:muscle_meals/models/key_manager.dart';
import 'package:muscle_meals/models/repository/pick_image_repository.dart';
import 'package:muscle_meals/style/colors.dart';
import 'package:muscle_meals/style/theme.dart';
import 'package:muscle_meals/utils/dialog.dart';
import 'package:muscle_meals/utils/utils.dart';
import 'package:muscle_meals/widgets/animated_text_field.dart';
import 'package:muscle_meals/widgets/app_bar_title.dart';
import 'package:muscle_meals/widgets/keyboard_overlay.dart';
import 'package:muscle_meals/widgets/macro_input.dart';
import 'package:muscle_meals/widgets/star_icon.dart';

class NewRecipePage extends StatefulWidget {
  const NewRecipePage({super.key});

  @override
  State<NewRecipePage> createState() => _NewRecipePageState();
}

class _NewRecipePageState extends State<NewRecipePage> {
  final _key = GlobalKey<FormState>();
  late ControllerManager _controllerManager;
  late FocusNodeManager _nodeManager;
  late KeyManager _keyManager;

  final _ingredientKey = GlobalKey<AnimatedListState>();
  final _stepKey = GlobalKey<AnimatedListState>();

  @override
  void initState() {
    super.initState();
    _controllerManager = ControllerManager();
    _nodeManager = FocusNodeManager();
    _keyManager = KeyManager();
  }

  @override
  void dispose() {
    _controllerManager.dispose();
    _nodeManager.dispose();

    KeyboardOverlay.removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return RepositoryProvider(
      create: (context) => PickImageRepository(),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ValidatorBloc(_controllerManager)),
          BlocProvider(
              create: (_) => FocusBloc(_nodeManager, _keyManager, context)),
          BlocProvider(
            create: (_) => RecipeControllersBloc(
                _controllerManager.ingredientControllers,
                _ingredientKey,
                _controllerManager.stepControllers,
                _stepKey,
                _nodeManager.ingredientNodes,
                _nodeManager.stepNodes,
                _keyManager),
          ),
          BlocProvider(
            create: (_) => DifficultyBloc(),
          ),
          BlocProvider(create: (_) => PickImageBloc(PickImageRepository()))
        ],
        child: BlocConsumer<FocusBloc, FocusState>(
          listener: (context, state) {
            if (state is HasFocusState) {
              KeyboardOverlay.showOverlay(context);
            } else if (state is HasntFocusState) {
              KeyboardOverlay.removeOverlay();
            }
          },
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                title: const AppBarTitle('Nouvelle recette'),
              ),
              body: Form(
                key: _key,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const Gap(10),
                      Focus(
                        onFocusChange: (value) => Utils.addFocusBloc(
                            context, value, _nodeManager.recipeNode),
                        child: TextFormField(
                          validator: (value) => Utils.recipeValidator(
                              value, 'Veuillez rentrer un nom de recette'),
                          textCapitalization: TextCapitalization.sentences,
                          autocorrect: false,
                          focusNode: _nodeManager.recipeNode,
                          controller: _controllerManager.recipeNameController,
                          textInputAction: TextInputAction.done,
                          decoration: const InputDecoration(
                              labelText: "Nom de la recette"),
                        ),
                      ),
                      const Gap(20),
                      Row(
                        children: [
                          BlocBuilder<PickImageBloc, PickImageState>(
                            builder: (context, state) {
                              return GestureDetector(
                                onTap: () =>
                                    DialogUtils.showImageSourceDialog(context),
                                child: Container(
                                  width: width * 0.5,
                                  height: width * 0.5,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(12)),
                                      color: AppColors.secondaryText
                                          .withOpacity(.3)),
                                  child: (state is UpdateImageSuccesfulState)
                                      ? Image.file(
                                          state.file,
                                          fit: BoxFit.cover,
                                        )
                                      : const Icon(
                                          Icons.add_a_photo_outlined,
                                          color: AppColors.clearGrey,
                                          size: 70,
                                        ),
                                ),
                              );
                            },
                          ),
                          const Gap(10),
                          SizedBox(
                            width: width * .38,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Difficulté',
                                  style: AppTheme.newRecipeStyle,
                                ),
                                BlocBuilder<DifficultyBloc, DifficultyState>(
                                  builder: (context, state) {
                                    return Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            3,
                                            (index) => StarIcon(
                                                difficultyLevel: state
                                                    .difficultyLevel[index],
                                                onPressed: () {
                                                  context
                                                      .read<DifficultyBloc>()
                                                      .add(
                                                          UpdateDifficultyEvent(
                                                              index));
                                                })));
                                  },
                                ),
                                const Text(
                                    textAlign: TextAlign.center,
                                    'Temps de préparation',
                                    style: AppTheme.newRecipeStyle),
                                const Gap(10),
                                SizedBox(
                                  width: width * 0.3,
                                  child: Focus(
                                    key: _keyManager.prepTimeKey,
                                    onFocusChange: (value) =>
                                        Utils.addFocusBloc(context, value,
                                            _nodeManager.prepTimeNode),
                                    child: BlocBuilder<ValidatorBloc,
                                        ValidatorState>(
                                      buildWhen: (previous, current) =>
                                          current is PrepTimeErrorState ||
                                          current is PrepTimeValidateState,
                                      builder: (context, state) {
                                        return TextFormField(
                                          focusNode: _nodeManager.prepTimeNode,
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                              hintText: '30',
                                              hintStyle: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryText),
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: Text(
                                                  'minutes',
                                                  style: TextStyle(
                                                      color: (state
                                                              is! PrepTimeErrorState)
                                                          ? AppColors
                                                              .charcoalBlack
                                                          : AppColors
                                                              .dynamicRed),
                                                ),
                                              ),
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none),
                                          controller: _controllerManager
                                              .prepTimeController,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const Text(
                                  'Calories',
                                  style: AppTheme.newRecipeStyle,
                                ),
                                const Gap(10),
                                SizedBox(
                                  width: width * 0.3,
                                  child: Focus(
                                    key: _keyManager.calorieKey,
                                    onFocusChange: (value) =>
                                        Utils.addFocusBloc(context, value,
                                            _nodeManager.calorieNode),
                                    child: BlocBuilder<ValidatorBloc,
                                        ValidatorState>(
                                      buildWhen: (previous, current) =>
                                          current is CalorieErrorState ||
                                          current is CalorieValidateState,
                                      builder: (context, state) {
                                        return TextFormField(
                                          focusNode: _nodeManager.calorieNode,
                                          keyboardType: TextInputType.number,
                                          controller: _controllerManager
                                              .calorieController,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              errorBorder:
                                                  const UnderlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  8)),
                                                      borderSide: BorderSide(
                                                          color: AppColors
                                                              .dynamicRed)),
                                              hintText: '200',
                                              hintStyle: const TextStyle(
                                                  color:
                                                      AppColors.tertiaryText),
                                              suffixIcon: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 2),
                                                child: Text(
                                                  'calories',
                                                  style: TextStyle(
                                                      color: (state
                                                              is! CalorieErrorState)
                                                          ? AppColors
                                                              .charcoalBlack
                                                          : AppColors
                                                              .dynamicRed),
                                                ),
                                              )),
                                        );
                                      },
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      const Gap(10),
                      Row(
                        key: _keyManager.macroKey,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          BlocBuilder<ValidatorBloc, ValidatorState>(
                            buildWhen: (previous, current) =>
                                current is ProteinErrorState ||
                                current is ProteinValidateState,
                            builder: (context, state) {
                              return MacroInput(
                                input: 'Protéines',
                                controller:
                                    _controllerManager.proteinController,
                                node: _nodeManager.proteinNode,
                                errorState: state is ProteinErrorState,
                              );
                            },
                          ),
                          BlocBuilder<ValidatorBloc, ValidatorState>(
                            buildWhen: (previous, current) =>
                                current is CarbErrorState ||
                                current is CarbValidateState,
                            builder: (context, state) {
                              return MacroInput(
                                input: 'Glucides',
                                controller: _controllerManager.carbController,
                                node: _nodeManager.carbNode,
                                errorState: state is CarbErrorState,
                              );
                            },
                          ),
                          BlocBuilder<ValidatorBloc, ValidatorState>(
                            buildWhen: (previous, current) =>
                                current is FatErrorState ||
                                current is FatValidateState,
                            builder: (context, state) {
                              return MacroInput(
                                input: 'Lipides',
                                controller: _controllerManager.fatController,
                                node: _nodeManager.fatNode,
                                errorState: state is FatErrorState,
                              );
                            },
                          )
                        ],
                      ),
                      const Gap(15),
                      const Text(
                        'Ingredients',
                        style: TextStyle(
                            color: AppColors.charcoalBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const Gap(10),
                      BlocBuilder<RecipeControllersBloc,
                          RecipeControllersState>(
                        buildWhen: (previous, current) =>
                            current is IngredientListUpdated,
                        builder: (context, state) {
                          return AnimatedList(
                              physics: const NeverScrollableScrollPhysics(),
                              key: _ingredientKey,
                              shrinkWrap: true,
                              initialItemCount: _controllerManager
                                      .ingredientControllers.length +
                                  1,
                              itemBuilder: (context, index, animation) {
                                if (index ==
                                    _controllerManager
                                        .ingredientControllers.length) {
                                  return TextButton(
                                      onPressed: () => context
                                          .read<RecipeControllersBloc>()
                                          .add(const AddIngredientEvent()),
                                      child:
                                          const Text('Ajouter un ingrédient'));
                                } else {
                                  return Column(
                                    key: _keyManager.ingredientKeys[index],
                                    children: [
                                      AnimatedTextField(
                                        animation: animation,
                                        index: index,
                                        focusNode:
                                            _nodeManager.ingredientNodes[index],
                                        controller: _controllerManager
                                            .ingredientControllers[index],
                                        hintText: 'Ingrédient ${index + 1}',
                                        event: DeleteIngredientEvent(index),
                                      ),
                                      const Gap(10)
                                    ],
                                  );
                                }
                              });
                        },
                      ),
                      const Gap(10),
                      const Text(
                        'Etapes',
                        style: TextStyle(
                            color: AppColors.charcoalBlack,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const Gap(10),
                      BlocBuilder<RecipeControllersBloc,
                          RecipeControllersState>(
                        buildWhen: (previous, current) =>
                            current is StepListUpdated,
                        builder: (context, state) {
                          return Column(
                            children: [
                              AnimatedList(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  key: _stepKey,
                                  initialItemCount: _controllerManager
                                          .stepControllers.length +
                                      1,
                                  itemBuilder: (context, index, animation) {
                                    if (index ==
                                        _controllerManager
                                            .stepControllers.length) {
                                      return TextButton(
                                          onPressed: () => context
                                              .read<RecipeControllersBloc>()
                                              .add(const AddStepEvent()),
                                          child:
                                              const Text('Ajouter une étape'));
                                    } else {
                                      return Column(
                                        key: _keyManager.stepKeys[index],
                                        children: [
                                          AnimatedTextField(
                                            focusNode:
                                                _nodeManager.stepNodes[index],
                                            animation: animation,
                                            index: index,
                                            controller: _controllerManager
                                                .stepControllers[index],
                                            hintText: 'Etape ${index + 1}',
                                            event: DeleteStepEvent(index),
                                          ),
                                          const Gap(10)
                                        ],
                                      );
                                    }
                                  }),
                            ],
                          );
                        },
                      ),
                      const Gap(10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: BlocConsumer<ValidatorBloc, ValidatorState>(
                          listener: (context, state) {
                            if (state is IngredientErrorState ||
                                state is FormErrorState ||
                                state is StepErrorState) {
                              DialogUtils.showErrorDialog(
                                  context, state.errorMessage!);
                            }
                          },
                          builder: (context, state) {
                            return ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<ValidatorBloc>()
                                      .add(ValidateEvent());
                                  if (_key.currentState!.validate() &&
                                      state is FormValidateState) {
                                    Logger().d('Validé');
                                  }
                                },
                                child: const Text(
                                  'Enregistrer',
                                  style: AppTheme.textButtonTheme,
                                ));
                          },
                        ),
                      ),
                      const Gap(50)
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
