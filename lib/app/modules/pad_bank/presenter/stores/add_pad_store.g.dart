// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_pad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AddPadStore on _AddPadStoreBase, Store {
  final _$stateAtom = Atom(name: '_AddPadStoreBase.state');

  @override
  AddPadState get state {
    _$stateAtom.reportRead();
    return super.state;
  }

  @override
  set state(AddPadState value) {
    _$stateAtom.reportWrite(value, super.state, () {
      super.state = value;
    });
  }

  final _$addPadAsyncAction = AsyncAction('_AddPadStoreBase.addPad');

  @override
  Future<void> addPad(Pad pad) {
    return _$addPadAsyncAction.run(() => super.addPad(pad));
  }

  final _$updatePadAsyncAction = AsyncAction('_AddPadStoreBase.updatePad');

  @override
  Future<void> updatePad(Pad pad) {
    return _$updatePadAsyncAction.run(() => super.updatePad(pad));
  }

  final _$_AddPadStoreBaseActionController =
      ActionController(name: '_AddPadStoreBase');

  @override
  dynamic setState(AddPadState value) {
    final _$actionInfo = _$_AddPadStoreBaseActionController.startAction(
        name: '_AddPadStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_AddPadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
