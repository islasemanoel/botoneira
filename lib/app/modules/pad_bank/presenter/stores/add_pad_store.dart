import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/add_pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/edit_pad.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/add_pad_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'add_pad_store.g.dart';

class AddPadStore = _AddPadStoreBase with _$AddPadStore;

abstract class _AddPadStoreBase with Store {

  final padBankStore = Modular.get<PadBankStore>();
  final addPadUC = Modular.get<AddPad>();
  final editPadUC = Modular.get<EditPad>();

  @observable
  AddPadState state = StartState();

  @action
  Future<void> addPad(Pad pad) async {
    setState(LoadingState());
    var result = await addPadUC.call(pad);    
   
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState(r)));
    padBankStore.getPads();    
  }

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
