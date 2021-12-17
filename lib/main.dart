import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'app/app_module.dart';
import 'app/app_widget.dart';
import 'app/modules/pad_bank/infra/repositories/db_helper.dart';

void main() async {
   WidgetsFlutterBinding
      .ensureInitialized();
  await DBHelper.instance.db;
  runApp(ModularApp(module: AppModule(), child: AppWidget()));
}