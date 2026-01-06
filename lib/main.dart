import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sehhago/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:sehhago/features/auth/presentation/pages/auth_test_screen.dart';
import 'package:sehhago/firebase_options.dart';
import 'package:sehhago/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => serviceLocator<AuthBloc>())],
      child: const MaterialApp(home: AuthTestScreen()),
    ),
  );
}
