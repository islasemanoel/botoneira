import 'package:botoneira/app/modules/shared/player.dart';
import 'package:botoneira/app/modules/pad_bank/domain/usecases/pick_audio_file.dart';
import 'package:botoneira/app/modules/shared/file_management.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'domain/usecases/add_pad.dart';
import 'domain/usecases/add_padbank.dart';
import 'domain/usecases/delete_pad.dart';
import 'domain/usecases/delete_pad_bank.dart';
import 'domain/usecases/edit_pad.dart';
import 'domain/usecases/edit_padbank.dart';
import 'domain/usecases/get_pads_from_pad_bank.dart';
import 'domain/usecases/update_pad_list.dart';
import 'infra/repositories/pad_bank_repository.dart';
import 'presenter/stores/add_pad_bank_store.dart';
import 'presenter/stores/add_pad_store.dart';
import 'presenter/stores/delete_pad_bank_store.dart';
import 'presenter/stores/delete_pad_store.dart';
import 'presenter/stores/pad_bank_store.dart';
import 'presenter/ui/pages/pad_bank_page.dart';

class PadBankModule extends Module {
  @override
  final List<Bind> binds = [
    Bind<PadBankRepository>((i) => PadBankRepositoryImpl()),
    Bind.singleton((i) => PadBankStore()),
    Bind.singleton((i) => AddPadStore()),
    Bind.singleton((i) => DeletePadStore()),
    Bind.singleton((i) => AddPadBankStore()),
    Bind.singleton((i) => DeletePadBankStore()),   
    Bind<PickAudioFile>((i) => PickAudioFileImpl(), isLazy: true),
    Bind<Player>((i) => PlayerImpl(), isSingleton: false),
    Bind<FileManagement>((i) => FileManagementImpl(), isLazy: true),
    Bind<AddPadBank>((i) => AddPadBank()),
    Bind<EditPadBank>((i) => EditPadBank()),
    Bind<DeletePadBank>((i) => DeletePadBank()),
    Bind<AddPad>((i) => AddPad()),
    Bind<EditPad>((i) => EditPad()),
    Bind<DeletePad>((i) => DeletePad()),    
    Bind<UpdatePadList>((i) => UpdatePadList()),    
    
    Bind<GetPadsFromPadBank>((i) => GetPadsFromPadBank()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => PadBankPage()),
  ];
}
