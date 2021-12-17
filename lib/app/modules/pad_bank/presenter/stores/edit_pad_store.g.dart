// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_pad_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EditPadStore on _EditPadStoreBase, Store {
  final _$stateAtom = Atom(name: '_EditPadStoreBase.state');

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

  final _$updatePadAsyncAction = AsyncAction('_EditPadStoreBase.updatePad');

  @override
  Future<void> updatePad(Pad pad) {
    return _$updatePadAsyncAction.run(() => super.updatePad(pad));
  }

  final _$_EditPadStoreBaseActionController =
      ActionController(name: '_EditPadStoreBase');

  @override
  dynamic setState(AddPadState value) {
    final _$actionInfo = _$_EditPadStoreBaseActionController.startAction(
        name: '_EditPadStoreBase.setState');
    try {
      return super.setState(value);
    } finally {
      _$_EditPadStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
state: ${state}
    ''';
  }
}
