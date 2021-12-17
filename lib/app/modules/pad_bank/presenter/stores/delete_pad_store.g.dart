// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delete_pad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DeletePadStore on _DeletePadStoreBase, Store {
  final _$stateAtom = Atom(name: '_DeletePadStoreBase.state');

  @override
  DeletePadState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(DeletePadState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$deletePadAsyncAction = AsyncAction('_DeletePadStoreBase.deletePad');

  @override
  Future<void> deletePad(Pad pad) {
    return _$deletePadAsyncAction.run(() => super.deletePad(pad));
  }

  final _$_DeletePadStoreBaseActionController =
      ActionController(name: '_DeletePadStoreBase');

  @override
  dynamic setState(DeletePadState value) {
    final _$actionInfo = _$_DeletePadStoreBaseActionController.startAction(
        name: '_DeletePadStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_DeletePadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
