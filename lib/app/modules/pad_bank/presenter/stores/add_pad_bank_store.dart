import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/add_padbank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/edit_padbank.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/add_pad_bank_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'add_pad_bank_store.g.dart';

class AddPadBankStore = _AddPadBankStoreBase with _$AddPadBankStore;

abstract class _AddPadBankStoreBase with Store {

  final padBankStore = Modular.get<PadBankStore>();
  final addPadBankUC = Modular.get<AddPadBank>();
  final editPadBankUC = Modular.get<EditPadBank>();
  
  @observable
  AddPadBankState state = StartState();

  @action
  Future<void> addPadBank(PadBank padBank) async {
    setState(LoadingState());
    var result = await addPadBankUC.addPadBank(padBank);    
   
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState(r)));
    await padBankStore. getPadBanks();
    padBankStore.setSelectedPadBank(padBankStore.padBankList[padBankStore.padBankList.length - 1]);
  }

  @action
  Future<void> updatePadBank(PadBank padBank) async {
    setState(LoadingState());
    var result = await editPadBankUC.updatePadBank(padBank);    
   
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState(r)));
    padBankStore.getPads();
  }

  @action
  setState(AddPadBankState value) => state = value;
}
