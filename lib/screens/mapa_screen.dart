import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:qr_scan/models/scan_model.dart';

//Clase que maneja la pantalla al elegir una scanmodel de tipo 'geo' el cual lleva a esta pantalla que es un google maps dentro de la app.

class MapaScreen extends StatefulWidget {
  const MapaScreen({Key? key}) : super(key: key);

  @override
  State<MapaScreen> createState() => _MapaScreenState();
}

class _MapaScreenState extends State<MapaScreen> {
//Declaramos e inicializamos las varaibles para cargar el controlador del mapa, selecionar el tipo de mapa y la lista de markers.
  Completer<GoogleMapController> _controller = Completer();
  late MapType _mapaActual = MapType.normal;
  Set<Marker> markers = new Set<Marker>();

//Metodo _onLongPress que al pulsar mucho tiempo pondra un marcador en la ubicacion que pulsemos mucho tiempo.
void _onLongPress(LatLng latLng){
  setState(() {
    
    markers.clear();
    markers.add(
      Marker(
        //Para que el id sea unico se usan sus puntos localizadores como id.
        markerId: MarkerId('marker_$latLng'),
        position: latLng),
    );
  });

}  

//Metodo para crear el controlador del mapa
void _mapaCreado(GoogleMapController controller){
  _controller.complete(controller);
}

  @override
  Widget build(BuildContext context) {
    //Se establece el punto de geolocalizacion del scanmodel en el mapa
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;
    final CameraPosition _puntinici = CameraPosition(target: scan.getLatLng(),
    zoom: 17);

    //Se agrega un marker azul que significa que es el punto inicial en el que hemos entrado
    markers.add(new Marker(markerId: MarkerId('id1'), position: scan.getLatLng(), icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue)));

  //Metodo que inicia el estado del tipo de mapa como normal.
    @override
  void initState() {
    super.initState();
    _mapaActual = MapType.normal; 
  }

  //Metodo que cambia el tipo de mapa de normal a hibrido y viceversa.
    void _cambiarTipoDeMapa(){
      setState(() {
        _mapaActual = _mapaActual == MapType.normal ? MapType.hybrid : MapType.normal;
      });
    }
  
    //Estructura de la pantalla del mapa.
    return Scaffold(
      //Agregamos un Appbar al mapa
      appBar: AppBar(  
      backgroundColor: Colors.deepPurple,
        title: Text('Google Maps', style: TextStyle(color: Colors.white)),
        actions: [
          //Boton que al pulsarlo devuelva al de la geolocalizacion que selecionamos incialmente para entrar al mapa, donde esta el puntero azul.
          IconButton(
            icon: Icon(Icons.location_pin),
            color: Colors.white,
            onPressed:() async { 
              final GoogleMapController controller = await _controller.future;
              controller.animateCamera(CameraUpdate.newCameraPosition(_puntinici));
              }
              ),
        ]
      ),
      //Aqui se manejan la configuracion y elementos que gestionara el googleMap
      body: Stack(
        children: [
        GoogleMap(
        myLocationEnabled: false,
        //Al hacer un long press pondra un marcador donde hemos realizado el longpress
        onLongPress: _onLongPress,
        mapType: _mapaActual,
        //Cargara los markers que hay
        markers: markers,
        initialCameraPosition: _puntinici,
        onMapCreated: _mapaCreado,
        ),
        //Ponemos el boton para cambiar el tipo de mapa a normal o a hibrido. 
        Positioned(
          bottom: 16,
          left: 16,
          child: FloatingActionButton(
            onPressed: ()  {              
              _cambiarTipoDeMapa();
            },
            child: Icon(Icons.map),
            ),
        ),
       ]
      ),
      
    );
  }
}
