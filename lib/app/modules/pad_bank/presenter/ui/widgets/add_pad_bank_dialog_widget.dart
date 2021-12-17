import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/add_pad_bank_store.dart';
import 'package:botoneira/app/modules/shared/my_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';


class AddPadBankDialogWidget extends StatefulWidget {
  final bool? isEdit;
  final PadBank? padBank;

  AddPadBankDialogWidget({
    Key? key,
    required this.isEdit,
    this.padBank,
  }) : super(key: key);

  @override
  _AddPadBankDialogWidgetState createState() => _AddPadBankDialogWidgetState();
}

class _AddPadBankDialogWidgetState extends State<AddPadBankDialogWidget> {
  
  AddPadBankStore addPadBankStore = Modular.get<AddPadBankStore>();
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  final _padNameController = TextEditingController();
  late PadBank padBankAux;

  @override
  void initState() {
    super.initState();
    padBankAux = widget.padBank ?? new PadBank(name: "");
    _padNameController.text = padBankAux.name;
  }

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = ScrollController();
    final MyToastImpl myToast = MyToastImpl();

    return AlertDialog(
        title: Text(
          widget.isEdit! ? 'Renomear botoneira' : 'Nova botoneira',
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
              _padNameController.text = '';
              Navigator.of(context).pop();
              //padBankStore.fetchPads();
            },
            child: Text('CANCELAR'.toUpperCase()),
          ),
          TextButton(
            onPressed: () async {
              if (widget.isEdit!) {
                if (_formStateKey.currentState!.validate()) {
                  _formStateKey.currentState!.save();

                  addPadBankStore
                      .updatePadBank(PadBank(
                          id: padBankAux.id, name: padBankAux.name))
                      .then((data) {
                    Navigator.of(context).pop();
                  });
                }
              } else {
                if (_formStateKey.currentState!.validate()) {
                  _formStateKey.currentState!.save();
                  padBankAux.name = _padNameController.text;
                  addPadBankStore.addPadBank(PadBank(
                    name: padBankAux.name,
                  ));
                  
                  myToast.showToast(
                      msg: "Botoneira adicionada com sucesso!",
                      toastLength: MyToastLength.LENGTH_LONG,
                      gravity: MyToastGravity.CENTER);
                  Navigator.of(context).pop();
                }
              }
            },
            child: Text(
              (widget.isEdit! ? 'EDITAR' : 'ADICIONAR'),
            ),
          ),
        ],
        content: SingleChildScrollView(
          // give a controller
          controller: _scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Form(
                key: _formStateKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Digite o nome da botoneira';
                        }
                        if (value.trim() == "") return "O campo está vazio!";
                        return null;
                      },
                      onSaved: (value) {
                        padBankAux.name = value!;
                      },
                      controller: _padNameController,
                      decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                width: 2, style: BorderStyle.solid)),
                        labelText: "Nome da botoneira",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
