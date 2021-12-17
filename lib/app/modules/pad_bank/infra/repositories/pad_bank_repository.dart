import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/mappers/pad_bank_mapper.dart';
import 'package:botoneira/app/modules/pad_bank/infra/mappers/pad_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sqflite/sqflite.dart';
import 'db_helper.dart';

abstract class PadBankRepository {
  Future<Either<Failure, List<Pad>>> getPads(int bankNumber);
  Future<Either<Failure, Pad>> addPad(Pad pad);
  Future<Either<Failure, bool>> deletePad(int id);
  Future<Either<Failure, Pad>> updatePad(Pad pad);
  Future<Pad> find(int id);
  Future<List<PadBank>> getPadBanks();
  Future<Either<Failure, PadBank>> addPadBank(PadBank padBank);
  Future<Either<Failure, bool>> deletePadBank(int id);
  Future<Either<Failure, PadBank>> updatePadBank(PadBank padBank);
  Future<Either<Failure, List<Pad>>> updatePadList(List<Pad> pad);
}

class PadBankRepositoryImpl extends Disposable implements PadBankRepository {
  static late Future<Database> _db;
  PadBankRepositoryImpl() {
    _db = DBHelper.instance.db;
  }

  @override
  void dispose() {}

  Future<Either<Failure, List<Pad>>> getPads(int bankNumber) async {
    var dbClient = await _db;
    List<Pad> pads = [];
    
    try {
      List<Map<String, dynamic>> maps = await dbClient.rawQuery("SELECT "
          "pad.id, "
          "pad.name, "
          "path, "
          "sequence, "
          "pad_bank.id as pad_bank_id, "
          "pad_bank.name as pad_bank_name "
          "FROM "
          "pad "
          "INNER JOIN pad_bank ON pad.pad_bank_id = pad_bank.id where pad_bank.id=$bankNumber order by sequence");

      if (maps.length > 0) {
        for (int i = 0; i < maps.length; i++) {
          pads.add(PadMapper.fromMap(maps[i]));
        }
      }
    } catch (e) {
      return left(ErrorDataBase());
    }
    //print("Pads lenth ${pads.length}");
    return right(pads);
  }

  Future<Either<Failure, Pad>> addPad(Pad pad) async {
    var dbClient = await _db;
    try {
      pad.id = await dbClient.insert('pad', PadMapper.toMap(pad));
    } catch (e) {
      return left(ErrorDataBase());
    }
    return pad.id == null ? left(DatasourceResultNull()) : right(pad);
  }

  Future<Either<Failure, Pad>> updatePad(Pad pad) async {
    var dbClient = await _db;
    int rowsUpdate = 0;
    try {
      rowsUpdate = await dbClient.update(
        'pad',
        PadMapper.toMap(pad),
        where: 'id = ?',
        whereArgs: [pad.id],
      );
    } catch (e) {
      return left(ErrorDataBase());
    }
    return rowsUpdate == 0 ? left(DatasourceResultNull()) : right(pad);
  }

  Future<Pad> find(int id) async {
    final dbClient = await _db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('pad', where: "id = ?", whereArgs: [id]);

    if (maps.length > 0) {
      return PadMapper.fromMap(maps[0]);
    } else {
      return Pad(name: "", path: "", index: 0, padBank: PadBank(name: ""));
    }
  }

  Future<Either<Failure, bool>> deletePad(int id) async {
    var dbClient = await _db;
    int rowsdeleted = await dbClient.delete(
      'pad',
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsdeleted == 0 ? left(NotFound()) : right(true);
  }

  Future<List<PadBank>> getPadBanks() async {
    var dbClient = await _db;
    List<Map<String, dynamic>> maps = await dbClient.query('pad_bank',
        columns: ['id, name'], orderBy: 'id', groupBy: 'id');
    List<PadBank> padBanks = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        padBanks.add(PadBankMapper.fromMap(maps[i]));
      }
    }
    return padBanks;
  }

  Future<Either<Failure, PadBank>> updatePadBank(PadBank padBank) async {
    var dbClient = await _db;
    int rowsUpdate = 0;
    try {
      rowsUpdate = await dbClient.update(
        'pad_bank',
        PadBankMapper.toMap(padBank),
        where: 'id = ?',
        whereArgs: [padBank.id],
      );
    } catch (e) {
      return left(ErrorDataBase());
    }
    return rowsUpdate == 0 ? left(DatasourceResultNull()) : right(padBank);
  }

  Future<Either<Failure, List<Pad>>> updatePadList(List<Pad> padList) async {
    var dbClient = await _db;

    try {
      dbClient.transaction((txn) async {
        Batch batch = txn.batch();
        for (var pad in padList) {
          batch.update(
            'pad',
            PadMapper.toMap(pad),
            where: 'id = ?',
            whereArgs: [pad.id],
          );
        }
        batch.commit();
      });
    } catch (e) {
      return left(ErrorDataBase());
    }
    return right(padList);
  }

  Future<Either<Failure, PadBank>> addPadBank(PadBank padBank) async {
    var dbClient = await _db;
    try {
      padBank.id =
          await dbClient.insert('pad_bank', PadBankMapper.toMap(padBank));
    } catch (e) {
      return left(ErrorDataBase());
    }
    return padBank.id == null ? left(DatasourceResultNull()) : right(padBank);
  }

  Future<Either<Failure, bool>> deletePadBank(int id) async {
    var dbClient = await _db;
    int rowsdeleted = await dbClient.delete(
      'pad_bank',
      where: 'id = ?',
      whereArgs: [id],
    );
    return rowsdeleted == 0 ? left(NotFound()) : right(true);
  }
  
}
