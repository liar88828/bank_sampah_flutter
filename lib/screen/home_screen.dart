import 'package:bank_sampah/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Clear login status

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme themeColor = Theme.of(context).colorScheme;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Required for fixedColor to work
        backgroundColor: themeColor.primaryContainer, // Background color of the bar
        selectedItemColor: themeColor.primary, // Color of the selected item
        unselectedItemColor: themeColor.onPrimary, // Color of unselected items
        currentIndex: 0,
        onTap: (index) {
          // Perform specific actions based on the tapped item
          switch (index) {
            case 0:
              print('Home tapped');
              break;
            case 1:
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //       builder: (context) => WasteListScreen(),
              //     ));
              break;
            case 2:
              print('Favorites tapped');
              break;
            case 3:
              print('Settings tapped');
              break;
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: 'Sampah',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () => _logout(context),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: const Center(
        child: Text('Selamat datang! Anda berhasil login.'),
      ),
    );
  }
}
