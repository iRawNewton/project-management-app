import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart'; // Import the generated firebase_options.dart

import 'core/themes/app_theme.dart';
import 'core/themes/theme_cubit.dart';
import 'features/splash_screen/pages/onboarding_screen.dart';
import 'users/admin/admin_accounts/bloc/admin_crud_bloc.dart';
import 'users/admin/admin_client/bloc/admin_crud_client_bloc.dart';
import 'users/admin/admin_developers/bloc/admin_crud_dev_bloc.dart';
import 'users/admin/admin_managers/bloc/admin_crud_manager_bloc.dart';
import 'users/admin/admin_projects/bloc/admin_projects_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
        // BlocProvider(
        //   create: (context) => UserBloc(),
        // ),
        BlocProvider(
          create: (context) => AdminCrudBloc(),
        ),
        BlocProvider(
          create: (context) => AdminCrudDevBloc(),
        ),
        BlocProvider(
          create: (context) => AdminCrudManagerBloc(),
        ),
        BlocProvider(
          create: (context) => AdminCrudClientBloc(),
        ),
        BlocProvider(
          create: (context) => AdminProjectsBloc(),
        ),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          ThemeData theme;
          switch (themeState) {
            case ThemeState.darkMode:
              theme = AppTheme.darkTheme;
              break;
            case ThemeState.lightMode:
              theme = AppTheme.lightTheme;
              break;
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Project Management Application',
            theme: theme,
            home: const OnBoardingScreen(),
          );
        },
      ),
    );
  }
}
