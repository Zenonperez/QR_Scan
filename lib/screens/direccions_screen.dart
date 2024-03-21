import 'package:flutter/material.dart';
import 'package:qr_scan/widgets/scan_tiles.dart';

//Clase que es la pantalla que maneja las lista de paginas web.

class DireccionsScreen extends StatelessWidget {
  const DireccionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScanTiles(tipus: 'http');
  }
}
