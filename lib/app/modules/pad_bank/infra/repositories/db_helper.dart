
import 'package:botoneira/app/modules/pad_bank/domain/entities/pad_bank.dart';
import 'package:botoneira/app/modules/pad_bank/infra/mappers/pad_bank_mapper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DBHelper  {
  static late Database _db;
  bool _dbInitialized = false;

  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  Future<Database> get db async {
    if (_dbInitialized) {
      return _db;
    }

    _db = await initDatabase();
    _dbInitialized = true;
    return _db;
  }

  initDatabase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'botoneira.db');
    var db = await openDatabase(path,
        version: 3, onCreate: _onCreate, onConfigure: _onConfigure);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS pad_bank (id INTEGER PRIMARY KEY autoincrement, name TEXT) ''');
    await db.execute(
        '''CREATE TABLE IF NOT EXISTS pad (id INTEGER PRIMARY KEY autoincrement, name TEXT, path TEXT, sequence INTEGER, pad_bank_id INTEGER, FOREIGN KEY (pad_bank_id) REFERENCES pad_bank (id) ON DELETE CASCADE)''');
     await db.execute(
        '''INSERT INTO pad_bank (name) values ('Padrão')''');  
  }

  static Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<PadBank> addPadBank(PadBank padBank) async {
    var dbClient = await db;
    padBank.id = await dbClient.insert('pad_bank', PadBankMapper.toMap(padBank));
    return padBank;
  }
}