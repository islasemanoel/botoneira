import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/pad_bank_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/ui/widgets/edit_pad_dialog_widget.dart';
import 'package:botoneira/app/modules/shared/my_toast.dart';
import 'package:botoneira/app/modules/shared/player.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import '../widgets/add_pad_bank_dialog_widget.dart';
import '../widgets/add_pad_dialog_widget.dart';
import '../widgets/delete_pad_bank_dialog_widget.dart';
import '../widgets/delete_pad_dialog_widget.dart';
import '../widgets/pad_widget.dart';
import '../widgets/drag_sort_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nine_grid_view/nine_grid_view.dart';
import 'package:rect_getter/rect_getter.dart';

class PadBankPage extends StatefulWidget {
  @override
  _PadBankPageState createState() => _PadBankPageState();
}

class _PadBankPageState extends State<PadBankPage> {
  PadBankStore padBankStore = Modular.get<PadBankStore>();
  List<Player> audioPlayerList = [];
  int moveAction = MotionEvent.actionUp;
  bool _canDelete = false;
  bool _canEdit = false;

  final List<String> padBankChoices = <String>[
    "Renomear Botoneira",
    "Nova Botoneira",
    "Excluir Botoneira",
    "Adicionar Botão"
  ];

  List<DropdownMenuItem<int>> _dropdownMenuItems = [];

  List<DropdownMenuItem<int>> buildDropdownMenuItems(List<PadBank> padBanks) {
    List<DropdownMenuItem<int>> items = [];
    for (PadBank padBank in padBanks) {
      items.add(
        DropdownMenuItem(
          value: padBank.id,
          child: Text(padBank.name.toString()),
        ),
      );
    }
    return items;
  }

  void onChangeDropdownItem(var selectedBankNum) {
    setState(() {
      padBankStore.setSelectedPadBankById(selectedBankNum);
    });
  }

  @override
  void initState() {
    if (padBankStore.padBankList.isEmpty) {
      padBankStore.getPadBanks();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var globalKeyEdit = RectGetter.createGlobalKey();
    var globalKeyDelete = RectGetter.createGlobalKey();

    Size size = MediaQuery.of(context).size;
    double padHeight;
    double padWidth;
    int colunas;

    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    if (isPortrait) {
      colunas = 3;
    } else {
      colunas = 6;
    }

    double value = size.width > size.height ? size.width : size.height;
    padHeight = value / colunas;
    padWidth = value / colunas;

    void _select(String choice) {
      if (choice == "Nova Botoneira") {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                AddPadBankDialogWidget(isEdit: false));
      }
      if (choice == "Renomear Botoneira") {
        showDialog(
            context: context,
            builder: (BuildContext context) => AddPadBankDialogWidget(
                isEdit: true, padBank: padBankStore.selectedPadBank));
      }
      if (choice == "Excluir Botoneira") {
        showDialog(
            context: context,
            builder: (BuildContext context) => DeletePadBankDialogWidget());
      }
      if (choice == "Adicionar Botão") {
        showDialog(
            context: context,
            builder: (BuildContext context) =>
                AddPadDialogWidget());
      }
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Botoneira',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.stop),
          onPressed: () => {
            audioPlayerList.map((audioPlayer) => audioPlayer.stopAudio())
            //for (var audioPlayer in audioPlayerList) {audioPlayer.stopAudio()}
          },
        ),
      ),

      body: Observer(builder: (_) {

        if (padBankStore.state.toString() == ErrorState(EmptyList()).toString()) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Nenhuma botoneira encontrada"),
                SizedBox(height: 10),
                ElevatedButton(
                    onPressed: () => {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddPadBankDialogWidget(isEdit: false))
                        },
                    child: Text("CRIAR NOVA BOTONEIRA"))
              ],
            ),
          );
        }

        if (padBankStore.state.toString() == LoadingState().toString()) {
          return Center(child: CircularProgressIndicator());
        }

        _dropdownMenuItems = buildDropdownMenuItems(padBankStore.padBankList);

        return Column(
          children: [
            Expanded(
              child: ListView(
                children: <Widget>[
                  Observer(builder: (_) {
                    return Container(
                      margin: EdgeInsets.only(
                          left: 10.0, top: 5.0, right: 10.0, bottom: 0.0),
                      padding: EdgeInsets.only(left: 12, right: 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Botoneira: ',
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              DropdownButton(
                                value: padBankStore.selectedPadBank!.id!,
                                items: _dropdownMenuItems,
                                onChanged: onChangeDropdownItem,
                              ),
                            ],
                          ),
                          PopupMenuButton(
                            onSelected: _select,
                            padding: EdgeInsets.zero,
                            itemBuilder: (BuildContext context) {
                              return padBankChoices.map((String choice) {
                                return PopupMenuItem<String>(
                                  value: choice,
                                  child: Text(choice),
                                );
                              }).toList();
                            },
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            Theme.of(context).primaryColorLight.withAlpha(100),
                      ),
                    );
                  }),
                  Observer(builder: (_) {
                    return DragSortViewCustom(
                      padBankStore.padList,
                      colunas: colunas,
                      space: 5,
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.all(0),
                      itemBuilder: (BuildContext context, int index) {
                        Pad pad = padBankStore.padList[index];
                        Player audioManagement =
                            Modular.get<Player>();
                        audioPlayerList.add(audioManagement);
                        return PadWidget(
                            height: padHeight,
                            width: padWidth,
                            padModel: pad,
                            audioManagement: audioManagement);
                      },
                      initBuilder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  AddPadDialogWidget(),
                            );
                          },
                          child: Container(
                            color: Color(0XFFCCCCCC),
                            child: Center(child: Icon(Icons.add)),
                          ),
                        );
                      },
                      onDragListener: (MotionEvent event, double itemWidth) {
                        switch (event.action) {
                          case MotionEvent.actionDown:
                            moveAction = event.action!;
                            break;

                          case MotionEvent.actionMove:
                            double x = event.globalX! + itemWidth;
                            double y = event.globalY! + itemWidth;

                            var rectDelete =
                                RectGetter.getRectFromKey(globalKeyDelete);

                            var rectEdit =
                                RectGetter.getRectFromKey(globalKeyEdit);

                            if (_canDelete &&
                                (x < rectDelete!.left ||
                                    x > rectDelete.right + 100 ||
                                    y < rectDelete.top)) {
                              _canDelete = false;
                            } else if (!_canDelete &&
                                x >= rectDelete!.left &&
                                x <= rectDelete.right + 100 &&
                                y >= rectDelete.top) {
                              _canDelete = true;
                            }

                            if (_canEdit &&
                                (x < rectEdit!.left ||
                                    x > rectEdit.right + 100 ||
                                    y < rectEdit.top)) {
                              _canEdit = false;
                            } else if (!_canEdit &&
                                x >= rectEdit!.left &&
                                x <= rectEdit.right + 100 &&
                                y >= rectEdit.top) {
                              _canEdit = true;
                            }

                            setState(() {});
                            break;

                          case MotionEvent.actionUp:
                            moveAction = event.action!;

                            if (_canDelete) {
                              Pad? pad = padBankStore.padList[event.dragIndex!];
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      DeletePadDialogWidget(pad: pad));

                              setState(() {
                                _canDelete = false;
                              });
                            }

                            if (_canEdit) {
                              int? id =
                                  padBankStore.padList[event.dragIndex!].id;
                              Pad pad = padBankStore.padList
                                  .singleWhere((padModel) => padModel.id == id);

                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      EditPadDialogWidget(pad: pad));
                              setState(() {
                                _canEdit = false;
                              });
                            }

                            for (int i = 0;
                                i < padBankStore.padList.length;
                                i++) {
                              padBankStore.padList[i].index = i;
                            }
                            padBankStore.updatePadList(padBankStore.padList);

                            setState(() {});
                            break;
                        }
                        return false;
                      },
                    );
                  }),
                ],
              ),
            ),
            Container(
              color: Theme.of(context).cardColor,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  FittedBox(
                      child: new RectGetter(
                          key: globalKeyEdit,
                          child: IconButton(
                            onPressed: () {
                              MyToastImpl().showToast(
                                  msg:
                                      "Arraste e solte um botão sobre este ícone para editá-lo",
                                  toastLength: MyToastLength.LENGTH_SHORT,
                                  gravity: MyToastGravity.BOTTOM_LEFT);
                            },
                            icon: Icon(
                              _canEdit ? Icons.edit : Icons.edit_outlined,
                            ),
                          ))),
                  FittedBox(
                      child: new RectGetter(
                    key: globalKeyDelete,
                    child: IconButton(
                      onPressed: () {
                        MyToastImpl().showToast(
                            msg:
                                "Arraste e solte um botão sobre este ícone para excluí-lo",
                            toastLength: MyToastLength.LENGTH_SHORT,
                            gravity: MyToastGravity.BOTTOM_RIGHT);
                      },
                      icon: Icon(
                        _canDelete ? Icons.delete : Icons.delete_outline,
                      ),
                    ),
                  ))
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
