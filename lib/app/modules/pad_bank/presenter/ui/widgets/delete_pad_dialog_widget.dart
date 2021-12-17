import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/shared/file_management.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/delete_pad_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/delete_pad_store.dart';
import 'package:botoneira/app/modules/shared/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeletePadDialogWidget extends StatefulWidget {
  final Pad pad;

  DeletePadDialogWidget({Key? key, required this.pad}) : super(key: key);

  @override
  _DeletePadDialogWidgetState createState() => _DeletePadDialogWidgetState();
}

class _DeletePadDialogWidgetState
    extends ModularState<DeletePadDialogWidget, DeletePadStore> {

  final FileManagement fileManagement = Modular.get<FileManagement>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AlertDialog(
          title: Text(
            'Excluir botão',
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
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('CANCELAR'.toUpperCase()),
            ),
            TextButton(
              onPressed: () async {
                controller.deletePad(widget.pad);
              },
              child: Text(
                ('EXCLUIR'),
              ),
            ),
          ],
          content: Text(
            "Deseja excluir o botão '" + widget.pad.name + "'?",
            style: TextStyle(fontSize: 15),
          ),
        ),
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
            fileManagement.deleteFileFromAppDir(widget.pad.path);
            Fluttertoast.showToast(
                msg: "Botão excluido com sucesso!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
            Navigator.of(context).pop();
            return Container();
          }
          if (state is ErrorState) {
            MyToastImpl().showToast(
                msg: "Erro!",
                toastLength: MyToastLength.LENGTH_LONG,
                gravity: MyToastGravity.CENTER);
            Navigator.of(context).pop();
            return Container();
          } else {
            return Container();
          }
        }),
      ],
    );
  }
}
