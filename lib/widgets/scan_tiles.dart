import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/utils/utils.dart';

//Esta clase maneja el widget de las listas para verlas e interactuar con ellas en sus diferentes pantallas.
//Aqui también se le da la funcionalidad de selecionarlas mediante click y mediante arrastrandolas

class ScanTiles extends StatelessWidget {
  final String tipus;
  
  const ScanTiles({Key? key, required this.tipus}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scanListProvider = Provider.of<ScanListProvider>(context);
    final scans = scanListProvider.scans;
    return ListView.builder(itemCount: scans.length, 
    itemBuilder: (_,index) => Dismissible(
    key: UniqueKey(),
    background: Container(
    color: const Color.fromARGB(255, 241, 89, 89),
    child: Align(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(Icons.delete_forever),
      ),
      alignment: Alignment.centerRight,
    ),
    
    ),
    //Si se desplaza fuera de la pantalla se eliminara el elemento scan model arrastrado.
    onDismissed: (DismissDirection direccio) {
      Provider.of<ScanListProvider>(context, listen: false).borrarPorId(scans[index].id!);
    },

    child: ListTile(
      leading: Icon(
        this.tipus == 'http'
        ? Icons.home_outlined
        : Icons.map_outlined,),
    title: Text(scans[index].valor),
    subtitle: Text(scans[index].id.toString()),
    trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey,),
    onTap: () {
      //Si se da click se utilizara dicho elemento para ir a la pagina web o al mapa.
      launchUrl(context, scans[index]);
    },
    ),
    ),
    );
  }
}