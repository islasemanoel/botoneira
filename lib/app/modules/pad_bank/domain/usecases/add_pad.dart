import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/file_management.dart';
import 'package:uuid/uuid.dart';

class AddPad {
  final repository = Modular.get<PadBankRepository>();
  final fileManagement = Modular.get<FileManagement>();
  var uuid = Uuid();

  Future<Either<Failure, Pad>> call(Pad pad) async {

    String newPath = await fileManagement.moveFileToAppDir(pad.path, uuid.v1());
    pad.path = newPath;    
    
    return repository.addPad(pad);
  }
}
