import 'package:botoneira/app/modules/pad_bank/domain/entities/pad.dart';
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/domain/errors/errors.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/add_pad.dart';
import 'package:botoneira/app/modules/pad_bank/infra/repositories/pad_bank_repository.dart';
import 'package:botoneira/app/modules/pad_bank/pad_bank_module.dart';
import 'package:botoneira/app/modules/shared/file_management.dart';
import 'package:flutter_modular/flutter_modular.dart' as modular;
import 'package:modular_test/modular_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

final pad = new Pad(
    name: "name",
    path: "path",
    index: 0,
    padBank: PadBank(id: 1, name: "Padrão"));

final padReturn = new Pad(
    id: 1,
    name: "name",
    path: "path",
    index: 0,
    padBank: PadBank(id: 1, name: "Padrão"));

class PadBankRepositoryMock extends Mock implements PadBankRepository {
  @override
  Future<Either<Failure, Pad>> addPad(pad) async {
    return Right(padReturn);
  }
}

class FileManagementMock extends Mock implements FileManagement {
  @override
  Future<String> moveFileToAppDir(String filePathSource, String newName) async {
    return "ok";
  }
}

void main() {
  initModule(PadBankModule(), replaceBinds: [
    modular.Bind<PadBankRepository>((i) => PadBankRepositoryMock()),
    modular.Bind<FileManagement>((i) => FileManagementMock()),
  ]);

  final addPadUC = new AddPad();

  test('Add new Pad in database', () async {
    Either<Failure, Pad> addPadResult = await addPadUC(pad);
    expect(addPadResult.isRight(), true);
    expect(addPadResult, Right(padReturn));
  });
}
