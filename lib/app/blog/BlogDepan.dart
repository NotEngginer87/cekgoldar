// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, duplicate_ignore, avoid_unnecessary_containers, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

import 'halamanartikel.dart';
import 'halamanvideo.dart';


class SelectBlog2 extends StatefulWidget {
  const SelectBlog2({Key? key}) : super(key: key);

  @override
  _SelectBlog2State createState() => _SelectBlog2State();
}

class _SelectBlog2State extends State<SelectBlog2> {
  int? hitungterbaca = 0;
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width - 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.grey[100]!,
                color: Colors.black,
                tabs: const [
                  GButton(
                    icon: LineIcons.newspaper,
                    text: 'Artikel',
                  ),
                  GButton(
                    icon: LineIcons.video,
                    text: 'Video',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
        Center(
          child: (_selectedIndex == 0)
              ? HalamanArtikel()
              : (_selectedIndex == 1)
                  ? HalamanVideo()
                      : Container(),
        )
      ],
    );
  }
}

