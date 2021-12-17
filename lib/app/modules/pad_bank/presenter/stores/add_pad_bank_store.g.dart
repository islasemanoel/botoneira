// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pad_bank_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPadBankStore on _AddPadBankStoreBase, Store {
  final _$stateAtom = Atom(name: '_AddPadBankStoreBase.state');

  @override
  AddPadBankState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AddPadBankState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$addPadBankAsyncAction =
      AsyncAction('_AddPadBankStoreBase.addPadBank');

  @override
  Future<void> addPadBank(PadBank padBank) {
    return _$addPadBankAsyncAction.run(() => super.addPadBank(padBank));
  }

  final _$updatePadBankAsyncAction =
      AsyncAction('_AddPadBankStoreBase.updatePadBank');

  @override
  Future<void> updatePadBank(PadBank padBank) {
    return _$updatePadBankAsyncAction.run(() => super.updatePadBank(padBank));
  }

  final _$_AddPadBankStoreBaseActionController =
      ActionController(name: '_AddPadBankStoreBase');

  @override
  dynamic setState(AddPadBankState value) {
    final _$actionInfo = _$_AddPadBankStoreBaseActionController.startAction(
        name: '_AddPadBankStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_AddPadBankStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
