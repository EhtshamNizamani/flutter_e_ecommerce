import 'package:flutter/material.dart';
import 'package:flutter_e_commerce/config/color/app_colors.dart';

class HomeProvider extends ChangeNotifier {
  Color _selectedColor = AppColors.white;
  int _selectedTab = 0;
  String _hoveredTab = ''; // Added to track hovered tab

  int get selectedTab => _selectedTab;

  late Color contactColor;
  late Color homeColor;
  late Color shopAllColor;
  late Color personColor;
  late Color cartColor;
  late Color womenColor;

  // Method to handle exiting hover state
  void incrementExit(name) {
    _hoveredTab = ''; // Clear hovered tab
    _updateColors(); // Update colors based on selected tab
  }

  // Method to handle hover state
  void updateLocation(name) {
    _hoveredTab = name; // Set hovered tab
    _updateColors(); // Update colors based on hovered tab
  }

  // Update the colors of the tabs based on the current selected and hovered state
  void _updateColors({bool? isInit}) {
    contactColor = (_selectedTab == 3 || _hoveredTab == 'Contact')
        ? AppColors.primary
        : _selectedColor;
    shopAllColor = (_selectedTab == 1 || _hoveredTab == 'SHOP ALL')
        ? AppColors.primary
        : _selectedColor;
    homeColor = (_selectedTab == 0 || _hoveredTab == 'Home')
        ? AppColors.primary
        : _selectedColor;
    personColor = (_selectedTab == 4 || _hoveredTab == 'Person')
        ? AppColors.primary
        : _selectedColor;
    cartColor = (_selectedTab == 5 || _hoveredTab == 'Cart')
        ? AppColors.primary
        : _selectedColor;
    womenColor = (_selectedTab == 2 || _hoveredTab == 'Women')
        ? AppColors.primary
        : _selectedColor;

    if (isInit == null) {
      notifyListeners();
    }
  }

  // Method to handle tab selection
  void changeTab(int index) {
    _selectedTab = index; // Set selected tab
    _hoveredTab = ''; // Clear hovered tab when a tab is clicked
    _updateColors(); // Update colors based on selected tab
  }

  // Set the initial colors when widget is built
  void setColors({bool? isInit, color}) {
    _selectedColor = color;
    _updateColors(isInit: isInit);
  }
}
