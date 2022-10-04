import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:raft_assignment/controllers/app_state_controller.dart';
import 'package:raft_assignment/views/home.dart';

import 'data.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  DataRepository.apiBox = await Hive.openBox('apiBox');
  DataRepository.categoriesBox = await Hive.openBox('categoriesBox');
  DataRepository.audioPlayerIdsBox = await Hive.openBox('audioPlayerIdsBox');
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(AppStateController()).initAudioPlayer();

    return GetMaterialApp(
        title: 'Raft Assignment',
        theme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.blue,
        ),
        home: GetX<AppStateController>(
          builder: (controller) {
            if (controller.player.value == null) {
              return const Scaffold(body: Center(child: Text('Loading ...')));
            }
            else {
              return const HomeView();
            }
          },
        )
    );
  }

}
