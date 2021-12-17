import 'package:audioplayers/audioplayers.dart';

abstract class Player {
  Player({playerId});
  bool isPlaying();
  Stream<String> get state;
  void playAudio(String path);
  void stopAudio(); 
}


class PlayerImpl implements Player{
  late AudioPlayer audioPlayer;

  PlayerImpl({playerId}) {
    audioPlayer = new AudioPlayer(playerId: playerId);
  }

  bool isPlaying() {
    return audioPlayer.state == PlayerState.PLAYING;
  }

  Stream<String> get state => audioPlayer.onPlayerStateChanged
      .map((event) => audioPlayer.state.toString());

  void playAudio(String path) async {
    stopAudio();
    await audioPlayer.play(path, isLocal: true);
  }

  void stopAudio() async {
    if (audioPlayer.state == PlayerState.PLAYING) {
      await audioPlayer.stop();
    }
  }

}
