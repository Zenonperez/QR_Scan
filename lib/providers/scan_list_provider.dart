import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/db_provider.dart';

//Clase que maneja las listas de donde se guardan los scans que hay en la base de datos para poder realizar operaciones con estos.
class ScanListProvider extends ChangeNotifier {
  List<ScanModel> scans = [];
  String tipusSeleccionat = 'http';

//Al introducir un nuevo scan model se agregara en la base de datos y en la lista de http. Los de geo no se guardaran en la lista.
  Future<ScanModel> nouScan(String valor) async {
    final nouScan = ScanModel(valor: valor);
    final id = await DBProvider.db.insertScan(nouScan);
    nouScan.id = id;

    if (nouScan.tipus == tipusSeleccionat) {
      this.scans.add(nouScan);
      notifyListeners();
    }
    return nouScan;
  }
  //Metodos pora realziar operaciones con las lsitas y las bases de datos.

//Se cargan todos los scans guardados en base de datos en un lista
  carregaScans() async {
    final scans = await DBProvider.db.getAllScans();
    this.scans = [...scans];
    notifyListeners();
  }

//Se cargan todos los scans guardados en la base de datos siempre que su tipo sea como el del parametro.
  carregaScansByTipus(String tipus) async {
    final scans = await DBProvider.db.getScanByTipus(tipus);
    this.scans = [...scans!];
    this.tipusSeleccionat = tipus;
    notifyListeners();
  }

//Se borran todo el contenido de las listas y de la base de datos
  borrarTodos() async {
    final scans = await DBProvider.db.deleteAllScans();
    this.scans.clear();
    notifyListeners();
  }

//Se borra un scanmodel de las lista y de la base de datos el cual su id es igual al del paramtro.
  borrarPorId(int id) async {
    final deleteScan = await DBProvider.db.deleteScan(id);
    this.scans.removeWhere((scan) => scan.id == id);
    notifyListeners();
  }
}
