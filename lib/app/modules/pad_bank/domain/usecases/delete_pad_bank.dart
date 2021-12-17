import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeletePadBank {
  final repository = Modular.get<PadBankRepository>();

  Future<Either<Failure, bool>> deletePadBank(PadBank padbak) async {  
    if(padbak.id!=null){  
      return repository.deletePadBank(padbak.id!);
    }else{
       return left(NotFound());
    }
  }
}