import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

//Clase que maneja el botono para realizar un escaneo de qr y guardar y redirigirse a una pagina web o un punto geo en google maps.
class ScanButton extends StatelessWidget {
  const ScanButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      //Aqui se realiza toda la accion del boton
      child: Icon(
        Icons.filter_center_focus,
      ),
      onPressed: () async {
        
        //Esto abrira la camara del dispositivo para escanear un qr.
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3D8BEF', 'Cancelar', false, ScanMode.QR);
        print(barcodeScanRes);
        //Al escaneralo se guardara como un nuevo scanmodel.
        final scanListProvider = Provider.of<ScanListProvider>(context, listen:false);
        ScanModel nouScan = ScanModel(valor: barcodeScanRes);
        scanListProvider.nouScan(barcodeScanRes);
        //Y se abrira.
        launchUrl(context, nouScan);
      },
    );
  }
}
