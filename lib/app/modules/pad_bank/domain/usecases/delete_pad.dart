import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DeletePad {
  final repository = Modular.get<PadBankRepository>();

  Future<Either<Failure, bool>> deletePad(Pad pad) async {  
    if(pad.id!=null){  
      return repository.deletePad(pad.id!);
    }else{
       return left(NotFound());
    }
  }
}
