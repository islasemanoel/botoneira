// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_pad_bank_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DeletePadBankStore on _DeletePadBankStoreBase, Store {
  final _$stateAtom = Atom(name: '_DeletePadBankStoreBase.state');

  @override
  DeletePadBankState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DeletePadBankState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$deletePadBankAsyncAction =
      AsyncAction('_DeletePadBankStoreBase.deletePadBank');

  @override
  Future<void> deletePadBank(PadBank pad) {
    return _$deletePadBankAsyncAction.run(() => super.deletePadBank(pad));
  }

  final _$_DeletePadBankStoreBaseActionController =
      ActionController(name: '_DeletePadBankStoreBase');

  @override
  dynamic setState(DeletePadBankState value) {
    final _$actionInfo = _$_DeletePadBankStoreBaseActionController.startAction(
        name: '_DeletePadBankStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_DeletePadBankStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
