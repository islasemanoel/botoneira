import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/delete_pad.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/delete_pad_state.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/stores/pad_bank_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'delete_pad_store.g.dart';

class DeletePadStore = _DeletePadStoreBase with _$DeletePadStore;

abstract class _DeletePadStoreBase with Store {
  final padBankStore = Modular.get<PadBankStore>();
  final deletePadUC = Modular.get<DeletePad>();

  @observable
  DeletePadState state = StartState();

  @action
  Future<void> deletePad(Pad pad) async {
    setState(LoadingState());
    await Future.delayed(Duration(seconds: 2));
    var result = await deletePadUC.deletePad(pad);
    setState(result.fold((l) => ErrorState(l), (r) => SuccessState()));
    padBankStore.getPads();
  }

  @action
  setState(DeletePadState value) => state = value;
}
