import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/app_cubit.dart';
import 'package:flutter_app/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UseCam extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Text('hello'),
          );
        },
      ),
    );
  }
}
