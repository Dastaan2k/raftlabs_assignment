import 'dart:convert';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../data.dart';

class AppStateController extends GetxController {

  RxBool isMusicPlaying = RxBool(true);

  Rxn<AudioPlayer> player = Rxn<AudioPlayer>();

  initAudioPlayer() async {

    for(var playerId in DataRepository.audioPlayerIdsBox.values) {
      await AudioPlayer(playerId: jsonDecode(jsonEncode(playerId))).release();
    }
    await DataRepository.audioPlayerIdsBox.clear();
    if(player.value == null) {
      String id = Random.secure().nextDouble().toString();
      player.value = AudioPlayer(playerId: id);
      await DataRepository.audioPlayerIdsBox.add(id);
      await player.value!.play(AssetSource('background_music.mp3'));
    }

  }

}