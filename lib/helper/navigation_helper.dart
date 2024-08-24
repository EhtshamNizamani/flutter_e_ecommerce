class NavigationHelper {
  static String getRouteName(String title) {
    switch (title) {
      case 'Profile':
        return '/profile';
      case 'Exercise':
        return '/exercise';
      case 'Settings':
        return '/settings';
      case 'History':
        return '/history';
      case 'SignOut':
        return '/signout';
      default:
        return '/'; // Default route or handle unknown titles
    }
  }
}
