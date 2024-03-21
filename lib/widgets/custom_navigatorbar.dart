import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';

//Aqui se maneja el widget que con los iconos que redirigiran gracias a los providers a la pagina de listas de mapas o de dirreciones.
//Si se pulsa el icono dirrecion te llevara a direccions_screens con la lista de dirreciones.
//Si se pulsa el icono mapa te llevara a mapas_screen con la lisita de geos.
class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //Aqui se encuentra el manejo de los botones que son los dos iconos mencionados antes
    return BottomNavigationBar(
        onTap:(int i) => uiProvider.selectedMenuOpt = i,
        elevation: 0,
        currentIndex: currentIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.compass_calibration),
            label: 'Direccions',
          )
        ]);
  }
}
