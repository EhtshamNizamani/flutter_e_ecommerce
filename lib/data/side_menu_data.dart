import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/model/menu_model.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(icon: Icons.home, title: 'Home'),
    MenuModel(icon: Icons.person, title: 'Profile'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.history, title: 'History'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
