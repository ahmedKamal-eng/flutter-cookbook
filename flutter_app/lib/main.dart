import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/using_camera.dart';
import 'package:flutter_app/video.dart';

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Plugin(),
    );
  }
}

class Plugin extends StatefulWidget {
  @override
  State<Plugin> createState() => _PluginState();
}

class _PluginState extends State<Plugin> {
  List<Widget> screens = [
    VideoPlay(),
    UseCam(),
  ];

  int _seclectItem = 0;

  void _toggleScreen(int index) {
    setState(() {
      _seclectItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_seclectItem],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            label: 'video',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            label: 'cam',
          ),
        ],
        currentIndex: _seclectItem,
        selectedItemColor: Colors.amber,
        onTap: _toggleScreen,
      ),
    );
  }
}
