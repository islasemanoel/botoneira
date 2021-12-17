import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';

class PadMapper {

  static Map<String, dynamic> toMap(Pad pad) {
    var map = <String, dynamic>{
      'id': pad.id,
      'name': pad.name,
      'path': pad.path,
      'sequence': pad.index,
      'pad_bank_id': pad.padBank.id
    };
    return map;
  }

  static Pad fromMap(Map<String, dynamic> map) {
    return Pad(
        id: map['id'],
        name: map['name'].toString(),
        path: map['path'].toString(),
        index: map['sequence'],
        padBank: PadBank(id: map['pad_bank_id'], name: map['pad_bank_name'].toString()));
  }
}
