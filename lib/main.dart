import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sehhago/firebase_options.dart';
import 'package:sehhago/sehha_go_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const SehhaGo());
}
