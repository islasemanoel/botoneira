// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pad_bank_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PadBankStore on _PadBankStoreBase, Store {
  final _$padListAtom = Atom(name: '_PadBankStoreBase.padList');

  @override
  List<Pad> get padList {
    _$padListAtom.reportRead();
    return super.padList;
  }

  @override
  set padList(List<Pad> value) {
    _$padListAtom.reportWrite(value, super.padList, () {
      super.padList = value;
    });
  }

  final _$padBankListAtom = Atom(name: '_PadBankStoreBase.padBankList');

  @override
  List<PadBank> get padBankList {
    _$padBankListAtom.reportRead();
    return super.padBankList;
  }

  @override
  set padBankList(List<PadBank> value) {
    _$padBankListAtom.reportWrite(value, super.padBankList, () {
      super.padBankList = value;
    });
  }

  final _$selectedPadBankAtom = Atom(name: '_PadBankStoreBase.selectedPadBank');

  @override
  PadBank? get selectedPadBank {
    _$selectedPadBankAtom.reportRead();
    return super.selectedPadBank;
  }

  @override
  set selectedPadBank(PadBank? value) {
    _$selectedPadBankAtom.reportWrite(value, super.selectedPadBank, () {
      super.selectedPadBank = value;
    });
  }

  final _$stateAtom = Atom(name: '_PadBankStoreBase.state');

  @override
  PadBankState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(PadBankState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$getPadsAsyncAction = AsyncAction('_PadBankStoreBase.getPads');

  @override
  Future<void> getPads() {
    return _$getPadsAsyncAction.run(() => super.getPads());
  }

  final _$getPadBanksAsyncAction = AsyncAction('_PadBankStoreBase.getPadBanks');

  @override
  Future<void> getPadBanks() {
    return _$getPadBanksAsyncAction.run(() => super.getPadBanks());
  }

  final _$updatePadListAsyncAction =
      AsyncAction('_PadBankStoreBase.updatePadList');

  @override
  Future<void> updatePadList(List<Pad> padList) {
    return _$updatePadListAsyncAction.run(() => super.updatePadList(padList));
  }

  final _$setSelectedPadBankAsyncAction =
      AsyncAction('_PadBankStoreBase.setSelectedPadBank');

  @override
  Future<void> setSelectedPadBank(PadBank newSelectionPadBank) {
    return _$setSelectedPadBankAsyncAction
        .run(() => super.setSelectedPadBank(newSelectionPadBank));
  }

  final _$setSelectedPadBankByIdAsyncAction =
      AsyncAction('_PadBankStoreBase.setSelectedPadBankById');

  @override
  Future<void> setSelectedPadBankById(int newSelectionPadBankId) {
    return _$setSelectedPadBankByIdAsyncAction
        .run(() => super.setSelectedPadBankById(newSelectionPadBankId));
  }

  final _$_PadBankStoreBaseActionController =
      ActionController(name: '_PadBankStoreBase');

  @override
  dynamic setState(PadBankState value) {
    final _$actionInfo = _$_PadBankStoreBaseActionController.startAction(
        name: '_PadBankStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_PadBankStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
padList: ${padList},
padBankList: ${padBankList},
selectedPadBank: ${selectedPadBank},
state: ${state}
    ''';
  }
}
