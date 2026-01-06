import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhago/core/routes/app_routes.dart';
import 'package:sehhago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sehhago/features/auth/presentation/pages/auth_test_screen.dart';
import 'package:sehhago/features/home/presentation/page/home_page.dart';
import 'package:sehhago/features/search/presentation/pages/search_page.dart';
import 'package:sehhago/firebase_options.dart';
import 'package:sehhago/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoutes.generateRoute,
        home: SearchPage(),
      ),
    ),
  );
}
