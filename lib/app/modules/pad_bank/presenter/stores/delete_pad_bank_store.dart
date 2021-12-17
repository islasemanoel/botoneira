import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/delete_pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/delete_pad_bank_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'delete_pad_bank_store.g.dart';

class DeletePadBankStore = _DeletePadBankStoreBase with _$DeletePadBankStore;

abstract class _DeletePadBankStoreBase with Store {
  final padBankStore = Modular.get<PadBankStore>();
  final deletePadBankUC = Modular.get<DeletePadBank>();

  @observable
  DeletePadBankState state = StartState();

  @action
  Future<void> deletePadBank(PadBank pad) async {
    setState(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    var result = await deletePadBankUC.deletePadBank(pad);
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState()));

    //if (state == SuccessState()) {
    //  print("foi");
      await padBankStore.getPadBanks();
      padBankStore.setSelectedPadBank(padBankStore.padBankList[0]);
    //}
  }

  @action
  setState(DeletePadBankState value) => state = value;
}
