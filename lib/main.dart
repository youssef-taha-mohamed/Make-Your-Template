import 'package:bloc/bloc.dart';
import 'package:e_you/layout/home_layout.dart';
import 'package:e_you/modules/messanger/screen_messanger.dart';
import 'package:e_you/shared/bloc_observer.dart';
import 'package:flutter/material.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MessangerScreen(),
    );
  }
}
