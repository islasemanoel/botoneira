import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/edit_pad.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/add_pad_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'edit_pad_store.g.dart';

class EditPadStore = _EditPadStoreBase with _$EditPadStore;

abstract class _EditPadStoreBase with Store {

  final padBankStore = Modular.get<PadBankStore>();

  final editPadUC = Modular.get<EditPad>();

  @observable
  AddPadState state = StartState();


  @action
  Future<void> updatePad(Pad pad) async {
    setState(LoadingState());
    var result = await editPadUC.updatePad(pad);    
   
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState(r)));
    padBankStore.getPads();
  }

  @action
  setState(AddPadState value) => state = value;
}
