import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

//Esta clase es el provider de la base de datos que se encarga de las setencias de la base de datos y del funcionamiento de esta.
class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

//Getter de la base para seleccionarla
  Future<Database> get database async {
    _database ??= await initDB();

    return _database!;
  }

//Metodo que crea la base de datos y la tabla que la maneja.
  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'Escans.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute('''
        CREATE TABLE Escans(
          id INTEGER PRIMARY KEY,
          tipus TEXT,
          valor TEXT
        )
''');
      },
    );
  }

//Setencia insert para guardar un scanmodel en la base de datos de forma raw
  Future<int> insertRawScan(ScanModel nouScan) async {
    final id = nouScan.id;
    final tipus = nouScan.tipus;
    final valor = nouScan.valor;

    final db = await database;

    final res = await db.rawInsert('''
    INSERT INTO Escans(id, tipus, valor)
      VALUES ($id, $tipus, $valor)
''');
    return res;
  }

//Setencia para insertar un scanmodel pero ahora mapeandolo sin agragarlo de manera raw
  Future<int> insertScan(ScanModel nouScan) async {
    final db = await database;

    final res = await db.insert('Escans', nouScan.toMap());
    return res;
  }

//Setencia getter que seleciona todos los scanmodels guardados en la base de datos
  Future<List<ScanModel>> getAllScans() async {
    final db = await database;
    final res = await db.query('Escans');
    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }

//Setencia getter que seleciona el scanmodel donde su id es igual (util para eliminar o interactuar con el este scan model)
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    final res = await db.query('Escans', where: 'id = ?', whereArgs: [id]);

    if (res.isNotEmpty) {
      return ScanModel.fromMap(res.first);
    }
    return null;
  }
//Setencia getter que selecciona una lista de tipos determinada
  Future<List<ScanModel>> getScanByTipus(String tipus) async {
    final db = await database;
    final res =
        await db.query('Escans', where: 'tipus = ?', whereArgs: [tipus]);

    return res.isNotEmpty ? res.map((e) => ScanModel.fromMap(e)).toList() : [];
  }
//Sentencia que actualiza un scanmodel existente guardado en la base de datos introduciendo una nuevo.
  Future<int> updateScan(ScanModel nouScan) async {
    final db = await database;
    final res = db.update('Escans', nouScan.toMap(),
        where: 'id = ?', whereArgs: [nouScan.id]);

    return res;
  }
//Sentencia que elimina todos los scanmodels guardados en la base de datos.
  Future<int> deleteAllScans() async {
    final db = await database;
    final res = await db.rawDelete('''
    DELETE FROM Escans
''');
    return res;
  }
//Sentencia que elimina un scanmodel determinado por su id
  Future<int> deleteScan(int id) async {
    final db = await database;
    final res = await db.delete('Escans', where: 'id = ?', whereArgs: [id]);
    return res;
  }
}
