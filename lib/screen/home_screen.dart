import 'package:bank_sampah/screen/about_screen.dart';
import 'package:bank_sampah/screen/auth/login_screen.dart';
import 'package:bank_sampah/screen/map/open_street_map_screen2.dart';
import 'package:bank_sampah/screen/sampah/daftar_sampah_screen.dart';
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
          type: BottomNavigationBarType.fixed,
          // Required for fixedColor to work
          backgroundColor: themeColor.primaryContainer,
          // Background color of the bar
          selectedItemColor: themeColor.primary,
          // Color of the selected item
          unselectedItemColor: themeColor.onPrimary,
          // Color of unselected items
          currentIndex: 0,
          onTap: (index) {
            // Perform specific actions based on the tapped item
            switch (index) {
              case 0:
                print('Home tapped');
                break;
              case 1:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WasteListScreen(null),
                    ));
                break;
              case 2:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OpenStreetMapScreen2(),
                    ));
                break;
              case 3:
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutScreen(),
                    ));
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
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info_outline),
              label: 'About',
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
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // // User Balance Card
                    // _buildBalanceCard(),
                    // const SizedBox(height: 24),

                    // Waste Categories
                    const Text(
                      'Kategori Sampah',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      children: [

                        _buildCategoryCard(
                          'Plastik',
                          Icons.delete_outline,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteListScreen('Plastik'))),
                        ),
                        _buildCategoryCard(
                          'Kertas',
                          Icons.description_outlined,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteListScreen('Kertas'))),
                        ),
                        _buildCategoryCard(
                          'Logam',
                          Icons.pedal_bike_rounded,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteListScreen('Logam'))),
                        ),
                        _buildCategoryCard(
                            'Elektronik',
                            Icons.devices,
                            () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        WasteListScreen('Elektronik')))),
                        _buildCategoryCard(
                          'Kaca',
                          Icons.screenshot_monitor,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteListScreen('Kaca'))),
                        ),
                        _buildCategoryCard(
                          'Organik',
                          Icons.energy_savings_leaf_sharp,
                          () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      WasteListScreen('Organik'))),
                        ),
                      ],
                    ),

                    // const SizedBox(height: 24),
                    //
                    // // Latest Transactions
                    // const Text(
                    //   'Transaksi Terakhir',
                    //   style: TextStyle(
                    //     fontSize: 18,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    // const SizedBox(height: 16),
                    // _buildTransactionItem(
                    //   'Setor Sampah Plastik',
                    //   'Rp 25.000',
                    //   '20 Des 2024',
                    //   Icons.arrow_upward,
                    //   Colors.green,
                    // ),
                    // _buildTransactionItem(
                    //   'Tarik Saldo',
                    //   'Rp 50.000',
                    //   '19 Des 2024',
                    //   Icons.arrow_downward,
                    //   Colors.red,
                    // ),
                  ],
                ))));
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon),
          onPressed: onPressed,
          color: Colors.green,
        ),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String title, IconData icon, onClick) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onClick,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 60,
                color: Colors.green,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionItem(
    String title,
    String amount,
    String date,
    IconData icon,
    Color color,
  ) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color),
        ),
        title: Text(title),
        subtitle: Text(date),
        trailing: Text(
          amount,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Saldo Anda',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Rp 150.000',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  icon: Icons.add,
                  label: 'Setor',
                  onPressed: () {
                    // TODO: Implement deposit
                  },
                ),
                _buildActionButton(
                  icon: Icons.account_balance_wallet,
                  label: 'Tarik',
                  onPressed: () {
                    // TODO: Implement withdrawal
                  },
                ),
                _buildActionButton(
                  icon: Icons.history,
                  label: 'Riwayat',
                  onPressed: () {
                    // TODO: Implement history
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IndexScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Welcome to Bank Sampah',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Recycle waste and make a better world.',
            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
          ),
          SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                FeatureCard(
                  icon: Icons.recycling,
                  title: 'Recycle Waste',
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>WasteListScreen('')));
                  },
                ),
                FeatureCard(
                  icon: Icons.account_balance_wallet,
                  title: 'Balance',
                  onTap: () {
                    print('Balance tapped');
                  },
                ),
                FeatureCard(
                  icon: Icons.history,
                  title: 'Transaction History',
                  onTap: () {
                    print('Transaction History tapped');
                  },
                ),
                FeatureCard(
                  icon: Icons.info,
                  title: 'About Us',
                  onTap: () {
                    // print('About Us tapped');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  FeatureCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 48,
              color: Colors.green,
            ),
            SizedBox(height: 8),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
