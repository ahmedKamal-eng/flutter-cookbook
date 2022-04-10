import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  late List<CameraDescription> cameras;
  late CameraDescription firstCamera;
  Future<void> getCameras() async {
    // Obtain a list of the available cameras on the device.
    cameras = await availableCameras();
    firstCamera = cameras.first;
    emit(CreateFirstCam());
  }
}
