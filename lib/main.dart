

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:note_app/shared/AppCubit.dart';
import 'package:note_app/shared/Bloc_Observer.dart';
import 'package:note_app/layout/homeLayout.dart';
import 'package:note_app/shared/CubitState.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit()..CreateDatabase(),
        child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, states){},
    builder: (context, states) {
      child:
      return MaterialApp(
      theme:ThemeData(
      ),
      debugShowCheckedModeBanner: false,
      home:HomeLayout() ,
      // home:AddTasks() ,
      );
    }
        ),
    );

  }
}
