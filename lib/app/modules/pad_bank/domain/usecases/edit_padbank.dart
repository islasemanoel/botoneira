import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../../../shared/file_management.dart';

class EditPadBank {
  final repository = Modular.get<PadBankRepository>();
  final FileManagement fileManagement = Modular.get<FileManagement>();

  Future<Either<Failure, PadBank>> updatePadBank(PadBank padBank) async {
    return repository.updatePadBank(padBank);
  }
}
