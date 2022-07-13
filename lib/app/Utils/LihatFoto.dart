
// ignore_for_file: file_names

import 'package:flutter/material.dart';

class LihatFoto extends StatelessWidget {
  const LihatFoto({
    Key? key,
    required this.foto,
  }) : super(key: key);
  final String? foto;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: MediaQuery.of(context).size.width,
        width: MediaQuery.of(context).size.width,
        child: Hero(
            tag: 'foto',
            child: Container(
              child: (foto == null)
                  ? Image(
                image: const NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/teledentistry-70122.appspot.com/o/foto_blog%2Fkosong.png?alt=media&token=652482ea-7fa4-451f-913a-912c83d3ebd1'),
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
              )
                  : Image(
                image: NetworkImage(foto!),
                height: MediaQuery.of(context).size.width * 0.7,
                width: MediaQuery.of(context).size.width * 0.7,
              ),
            )));
  }
}