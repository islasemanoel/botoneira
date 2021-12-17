import 'package:botoneira/app/modules/pad_bank/presenter/stores/delete_pad_bank_store.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeletePadBankDialogWidget extends StatelessWidget {
  final DeletePadBankStore deltePadBankStore =
      Modular.get<DeletePadBankStore>();
  final PadBankStore padBankStore = Modular.get<PadBankStore>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Excluir botoneira',
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
            deltePadBankStore
                .deletePadBank(padBankStore.selectedPadBank!)
                .then((data) {
              Fluttertoast.showToast(
                  msg: "Botoneira excluida com sucesso!",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1);
              Navigator.of(context).pop();
            });
          },
          child: Text(
            ('EXCLUIR'),
          ),
        ),
      ],
      content: Text(
        "Deseja excluir a botoneira '" +
            padBankStore.selectedPadBank!.name +
            "'?",
        style: TextStyle(fontSize: 15),
      ),
    );
  }
}
