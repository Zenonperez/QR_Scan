import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_scan/providers/scan_list_provider.dart';
import 'package:qr_scan/providers/ui_provider.dart';
import 'package:qr_scan/screens/screens.dart';
import 'package:qr_scan/widgets/widgets.dart';

//Esta clase es la pantalla home la cual es la pantalla principal de la aplicacion aqui se gestiona la estructura,
//de pantallas de la aplicacion.

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

//Build el cual contruye la estructura de la aplicacion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Appbar de la aplicacion
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Historial', style: TextStyle(color: Colors.white)),
        actions: [
          //Este boton elimina todo el contenido de la base de datos y de las listas.
          IconButton(
            icon: Icon(Icons.delete_forever),
            color: Colors.white,
            onPressed: () {
              Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
            },
          )
        ],
      ),
      body: _HomeScreenBody(),
      bottomNavigationBar: CustomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomeScreenBody extends StatelessWidget {
  const _HomeScreenBody({Key? key}) : super(key: key);

//Aqui se maneja con un switch los cambios de pantalla al darle a un boton u otro usando el uiProvider.
  @override
  Widget build(BuildContext context) {
    final uiProvider = Provider.of<UIProvider>(context);
    
    final currentIndex = uiProvider.selectedMenuOpt;

    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.carregaScansByTipus('geo');
        return MapasScreen();

      case 1:
        scanListProvider.carregaScansByTipus('http');
        return DireccionsScreen();

      default:
        scanListProvider.carregaScansByTipus('geo');
        return MapasScreen();
    }
  }
}
