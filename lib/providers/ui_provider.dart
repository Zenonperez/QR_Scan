import 'package:flutter/material.dart';

//Clase de provider que maneja los menus de al pulsar los botones.
//Esto hace posible cambiar de lista cada vez que pulsa el boton.
class UIProvider extends ChangeNotifier {
  int _selectedMenuOpt = 1;

  int get selectedMenuOpt {
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int index) {
    this._selectedMenuOpt = index;
    notifyListeners();
  }
}
