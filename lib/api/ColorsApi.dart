// ignore_for_file: file_names

import 'package:flutter/material.dart';

class IsiQueColors {
  IsiQueColors._(); // this basically makes it so you can instantiate this class

  static const MaterialColor isiqueblue = MaterialColor(
    _isiqueblue,
    <int, Color>{
      100: Color(0xFFd4f0fc),
      200: Color(0xFF89d6fb),
      300: Color(_isiqueblue),
      400: Color(0xFF02577a),
      500: Color(0xFF01303f),
    },
  );
  static const int _isiqueblue = 0xFF02a9f7;

  static const MaterialColor isiquenanda = MaterialColor(
    _isiqueblue,
    <int, Color>{

      50: Color(0xFFCBB488),
      100: Color(0xFF5B6F83),
      200: Color(0xFF2A4C74),
      300: Color(_isiquenanda),
      400: Color(0xFFA69B82),
      500: Color(0xFFA9AEAD),
      600: Color(0xFF919D9F),
      700: Color(0xFF75694D),
      800: Color(0xFFB4BCB0),
      900: Color(0xFF3C3C3C),
    },
  );
  static const int _isiquenanda = 0xFF282010;


}