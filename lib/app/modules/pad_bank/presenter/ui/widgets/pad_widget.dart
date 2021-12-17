import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/shared/player.dart';
import 'package:flutter/material.dart';

class PadWidget extends StatelessWidget {
  PadWidget(
      {required this.height,
      required this.width,
      required this.padModel,
      required this.audioManagement});

  final double height;
  final double width;
  final Pad padModel;
  final Player audioManagement;
 
  Future<void> play() async {
    stop();
    audioManagement.playAudio(padModel.path);
  }

  Future<void> stop() async {
    if (audioManagement.isPlaying()) {
      audioManagement.stopAudio();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * .88,
      width: width * .88,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent),
        ),
        child: SizedBox.expand(
            child: Material(
          color: Colors.blueAccent,
          child: InkWell(
            enableFeedback: false,
            onTap: () => play(),
            child: Center(
                child: Text(
              padModel.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
        )),
      ),
    );
  }
}
