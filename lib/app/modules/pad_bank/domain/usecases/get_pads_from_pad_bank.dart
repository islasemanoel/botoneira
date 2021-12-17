import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

class GetPadsFromPadBank {
  final repository = Modular.get<PadBankRepository>();

  Future<Either<Failure, List<Pad>>> call(padBankId) async {
    return repository.getPads(padBankId);
  }
}
