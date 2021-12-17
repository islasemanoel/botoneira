import 'package:flutter_modular/flutter_modular.dart';
import 'modules/pad_bank/pad_bank_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: PadBankModule()),
  ];

}