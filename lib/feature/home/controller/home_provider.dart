import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';

class HomeProvider extends ChangeNotifier {
  Color _selectedColor = AppColors.white;
  int _selectedTab = 0;

  int get selectedTab => _selectedTab;

  late Color contactColor;
  late Color homeColor;
  late Color shopAllColor;
  late Color personColor;
  late Color cartColor;
  void incrementExit(name) {
    contactColor = _selectedColor;
    shopAllColor = _selectedColor;
    homeColor = _selectedColor;
    personColor = _selectedColor;
    cartColor = _selectedColor;
    notifyListeners();
  }

  void updateLocation(name) {
    switch (name) {
      case 'SHOP ALL':
        shopAllColor = AppColors.primary;
      case 'Contact':
        contactColor = AppColors.primary;
      case 'Home':
        homeColor = AppColors.primary;
      case 'Person':
        personColor = AppColors.primary;
      case 'Cart':
        cartColor = AppColors.primary;

        break;
      default:
    }
    notifyListeners();
  }

  void changeTab(int index) {
    _selectedTab = index;
    switch (index) {
      case 0:
        homeColor = AppColors.primary;
      case 1:
        shopAllColor = AppColors.primary;
      case 2:
        contactColor = AppColors.primary;
        break;
      default:
    }
    notifyListeners();
  }

  void setColors(color) {
    _selectedColor = color;
    contactColor = _selectedColor;
    homeColor = _selectedColor;
    shopAllColor = _selectedColor;
    personColor = _selectedColor;
    cartColor = _selectedColor;
  }
}
