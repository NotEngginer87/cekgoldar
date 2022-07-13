// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'package:flutter/material.dart';


class EdukasiDSMQcard extends StatefulWidget {
  const EdukasiDSMQcard(this.id, this.jd, this.ed,
      {Key? key})
      : super(key: key);

  final String id;
  final String jd;
  final String ed;

  @override
  State<EdukasiDSMQcard> createState() => _EdukasiDSMQcardState();
}

class _EdukasiDSMQcardState extends State<EdukasiDSMQcard> {
  @override
  Widget build(BuildContext context) {


    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Card(
          clipBehavior: Clip.antiAlias,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.jd,
                          style: const TextStyle(
                              fontSize: 18, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.ed,
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.left,
                        ),

                      ],
                    ),
                  )))),
    );
  }
}
