import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/add_pad_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/add_pad_store.dart';
import 'package:botoneira/app/modules/shared/my_toast.dart';
import 'package:botoneira/app/modules/shared/player.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/pick_audio_file.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

class EditPadDialogWidget extends StatefulWidget {
  final Pad pad;

  EditPadDialogWidget({
    Key? key,
    required this.pad,
  }) : super(key: key);

  @override
  _EditPadDialogWidgetState createState() => _EditPadDialogWidgetState();
}

class _EditPadDialogWidgetState
    extends ModularState<EditPadDialogWidget, AddPadStore> {
  PadBankStore padBankStore = Modular.get<PadBankStore>();
  PickAudioFile audioPicker = Modular.get<PickAudioFile>();
  Player audioManagement = Modular.get<Player>();

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  TextEditingController _padNameController = TextEditingController();

  late String _initFileName;
  late Pad _newPad;

  @override
  void initState() {
    super.initState();

    _newPad = widget.pad;
    _initFileName = _newPad.path;
    _padNameController.text = _newPad.name;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();

    return Stack(
      children: [
        AlertDialog(
            title: Text(
              'Editar botão',
              textAlign: TextAlign.center,
            ),
            titleTextStyle: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('CANCELAR'),
                onPressed: () {
                  _padNameController.text = '';
                  audioManagement.stopAudio();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('EDITAR'),
                onPressed: () async {
                  audioManagement.stopAudio();
                  if (_newPad.path == "") {
                    MyToastImpl().showToast(
                        msg: "Selecione um arquivo de áudio!",
                        toastLength: MyToastLength.LENGTH_LONG);
                  } else {
                    if (_formStateKey.currentState!.validate()) {
                      _formStateKey.currentState!.save();

                      controller.updatePad(Pad(
                          id: _newPad.id,
                          name: _newPad.name,
                          path: _newPad.path,
                          index: _newPad.index,
                          padBank: padBankStore.selectedPadBank!));
                    }
                  }
                },
              )
            ],
            content: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    autovalidateMode: AutovalidateMode.always,
                    key: _formStateKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Digite o nome do botão';
                            }
                            if (value.trim() == "")
                              return "O campo está vazio!";
                            return null;
                          },
                          onSaved: (value) {
                            _newPad.name = value!;
                          },
                          controller: _padNameController,
                          decoration: InputDecoration(
                            focusedBorder: new UnderlineInputBorder(
                                borderSide: new BorderSide(
                                    width: 2, style: BorderStyle.solid)),
                            labelText: "Nome do botão",
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "Arquivo de áudio: ",
                    style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          child: Text("Selecionar áudio"),
                          onPressed: () async {
                             audioManagement.stopAudio();
                            String? path = await audioPicker();
                            if (path != null) {
                              _initFileName = path.substring(
                                  (path.lastIndexOf("/") + 1),
                                  path.lastIndexOf("."));

                              _newPad.path = path;
                              _newPad.index = padBankStore.padList.length;
                              setState(() {});
                            }
                          }),
                      SizedBox(width: 5),
                      StreamBuilder<String>(
                          stream: audioManagement.state,
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (_newPad.path == "") {
                              return SizedBox();
                            }
                            if (audioManagement.isPlaying())
                              return IconButton(
                                  icon: const Icon(Icons.stop),
                                  onPressed: () async {
                                    audioManagement.stopAudio();
                                  });
                            if (_newPad.path != "" &&
                                !audioManagement.isPlaying())
                              return IconButton(
                                  icon: const Icon(Icons.play_arrow),
                                  onPressed: () async {
                                    audioManagement.playAudio(_newPad.path);
                                  });
                            return SizedBox();
                          }),
                      SizedBox(width: 5),
                    ],
                  ),
                  Text(_initFileName),
                ],
              ),
            )),
        Observer(builder: (_) {
          var state = controller.state;
          if (state is StartState) {
            return Container();
          }
          if (state is LoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SuccessState) {
            MyToastImpl().showToast(
                msg: "Botão editado com sucesso!",
                toastLength: MyToastLength.LENGTH_LONG,
                gravity: MyToastGravity.CENTER);
            Navigator.of(context).pop();
            return Container();
          }
          if (state is ErrorState) {
            MyToastImpl().showToast(
                msg: "Erro!",
                toastLength: MyToastLength.LENGTH_LONG,
                gravity: MyToastGravity.CENTER);
            return Container();
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
