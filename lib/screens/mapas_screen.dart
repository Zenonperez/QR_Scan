import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

//Clase que es la pantalla que maneja las lista de geolocalizaciones guardadas.

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'geo');
  }
}
