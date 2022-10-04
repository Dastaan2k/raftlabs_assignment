import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raft_assignment/controllers/app_state_controller.dart';
import 'package:raft_assignment/views/page_1.dart';
import 'package:raft_assignment/views/page_2.dart';
import 'package:raft_assignment/views/page_3.dart';
import 'package:raft_assignment/views/page_4.dart';
import 'package:raft_assignment/views/widgets/bottom_nav_bar.dart';


class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {

  late TabController _controller;

  AppStateController appStateController = Get.put(AppStateController());

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    appStateController.player.value?.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TabBarView(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            Page1(),
            Page2(),
            Page3(),
            Page4()
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fabButtonCallback,
        child: StreamBuilder(
          stream: appStateController.player.value!.onPlayerStateChanged,
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.active) {
              return Icon(snapshot.data == PlayerState.playing ? Icons.pause : Icons.play_arrow, size: 34);
            }
            else {
              return const Icon(Icons.downloading, size: 34);
            }
          },
        )
      ),
      bottomNavigationBar: BottomNavBar(controller: _controller),
    );
  }

  fabButtonCallback() async {
    if(appStateController.player.value!.state == PlayerState.playing) {
      await appStateController.player.value!.pause();
    }
    else {
      await appStateController.player.value!.resume();
    }
  }

}


