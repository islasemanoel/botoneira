import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';

class PadBankMapper{

  static Map<String, dynamic> toMap(PadBank padBank) {
    var map = <String, dynamic>{'id': padBank.id, 'name': padBank.name};
    return map;
  }

  static PadBank fromMap(Map<String, dynamic> map) {
    return PadBank(
      id: map['id'],
      name: map['name'].toString(),
    );
  }
}