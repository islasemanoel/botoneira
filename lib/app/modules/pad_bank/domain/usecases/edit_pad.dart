import 'dart:io';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/file_management.dart';
import 'package:uuid/uuid.dart';

class EditPad {
  final repository = Modular.get<PadBankRepository>();
  final fileManagement = Modular.get<FileManagement>();

  var uuid = Uuid();

  Future<Either<Failure, Pad>> updatePad(Pad pad) async {
    File file = File(pad.path);
    if (!await file.exists()) {
      return left(FileSourceNotFound());
    }

    String newPath = await fileManagement.moveFileToAppDir(pad.path, uuid.v1());
    pad.path = newPath;


    Pad oldPad = await repository.find(pad.id!);
    if (oldPad.path != newPath) {
      fileManagement.deleteFileFromAppDir(oldPad.path);
    }

    return repository.updatePad(pad);
  }
}
