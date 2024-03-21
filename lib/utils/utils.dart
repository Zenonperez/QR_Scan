import 'package:flutter/material.dart';
import 'package:qr_scan/models/scan_model.dart';
import 'package:url_launcher/url_launcher.dart';

//Clase que utilizaremos para cargar las url de las paginas web y los puntos geolocalizadores.

void launchUrl(BuildContext context, ScanModel scan) async {
  final url =scan.valor;
  if(scan.tipus == 'http'){
     if (!await launch(url)) {
    throw Exception('Could not launch $url');
     }
  }else{
    
    Navigator.pushNamed(context, 'mapa', arguments: scan);
  }
  }
 