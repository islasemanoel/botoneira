import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/get_pads_from_pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/update_pad_list.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:botoneira/app/modules/pad_bank/presenter/states/pad_bank_state.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
part 'pad_bank_store.g.dart';

class PadBankStore = _PadBankStoreBase with _$PadBankStore;

abstract class _PadBankStoreBase with Store {
  final repository = Modular.get<PadBankRepository>();
  final updatePadListUC = Modular.get<UpdatePadList>();
  final getPadsFromPadBankUC = Modular.get<GetPadsFromPadBank>();

  @observable
  List<Pad> padList = [];

  @observable
  List<PadBank> padBankList = [];

  @observable
  PadBank? selectedPadBank;

  @observable
  PadBankState state = StartState();

  @action
  Future<void> getPads() async {
    setState(LoadingState());
    try {
      var result = await getPadsFromPadBankUC(selectedPadBank!.id!);

      setState(result.fold((l) => ErrorState(l), (r) {
        padList = r;
        return SuccessState();
      }));
    } catch (e) {
      setState(ErrorState(Failure()));
    }
  }

  @action
  Future<void> getPadBanks() async {
    setState(LoadingState());
    try {
      padBankList = await repository.getPadBanks();
      if (selectedPadBank == null && padBankList.length > 0) {
        setSelectedPadBank(padBankList[0]);
      }else if (padBankList.length == 0){
        print("lista vazia");
          setState(ErrorState(EmptyList()));
      }else{
        setState(SuccessState());
      }
    } catch (e) {
      //error = Exception('Error: ' + e.toString());
      setState(ErrorState(Failure()));
    }
    
  }

  @action
  Future<void> updatePadList(List<Pad> padList) async {
    await updatePadListUC.updatePadBankList(padList);

    //setState(LoadingState());
    //var result = await updatePadListUC.updatePadBankList(padList);
    //setState(result.fold((l) => ErrorState(l), (r) => SuccessState(r)));
    //fetchPads();
  }

  @action
  Future<void> setSelectedPadBank(PadBank newSelectionPadBank) async {
    selectedPadBank = newSelectionPadBank;
    getPads();
  }

  @action
  Future<void> setSelectedPadBankById(int newSelectionPadBankId) async {
    for (var padBank in padBankList) {
      if (padBank.id == newSelectionPadBankId) {
        setSelectedPadBank(padBank);
      }
    }
  }

  @action
  setState(PadBankState value) => state = value;
}
