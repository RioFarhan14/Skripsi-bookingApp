import 'dart:async'; // Import untuk Timer
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:user_frontend/providers/authProvider.dart';
import 'package:user_frontend/screens/activity/main.dart';
import 'package:user_frontend/screens/home.dart';
import 'package:user_frontend/screens/profile/main.dart';
import 'package:user_frontend/utils/theme.dart';
import 'package:user_frontend/widgets/appBarActivity.dart';
import 'package:user_frontend/widgets/appBarHome.dart';
import 'package:user_frontend/widgets/appBarProfile.dart';
import 'package:user_frontend/widgets/buttonMembership.dart';

class MenuNavigation extends StatefulWidget {
  final int initialIndex;

  const MenuNavigation({super.key, this.initialIndex = 0});

  @override
  State<MenuNavigation> createState() => _MenuNavigationState();
}

class _MenuNavigationState extends State<MenuNavigation> {
  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _startFetchingData(); // Mulai fetch data saat widget diinisialisasi
  }

  void _startFetchingData() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.tryAutoLogin();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Hentikan timer saat widget dihapus
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizeHeight = MediaQuery.of(context).size.height;

    return Consumer<AuthProvider>(builder: (context, auth, child) {
      final userData = auth.userData;
      final isMember = userData?['isMember'] ?? false;

      List<Widget> bodyWidget = [
        const HomePage(),
        const ActivityPage(),
        const ProfilePage(),
      ];

      List<Widget> appWidget = [
        Consumer<AuthProvider>(builder: (context, auth, child) {
          final userData = auth.userData;
          if (userData == null || userData['name'] == null) {
            return const Center(
                child: CircularProgressIndicator()); // Menampilkan loading
          }

          return AppBarHome(
            title: 'Selamat Datang,',
            subtitle: userData['name'],
            onNotificationPressed: () {
              Navigator.pushNamed(context, '/information');
            },
          );
        }),
        const AppBarActivity(
          title: 'Aktivitas',
        ),
        const AppBarProfile(title: 'Profil'),
      ];

      return Scaffold(
        bottomNavigationBar: ConvexAppBar(
          backgroundColor: darkBlueColor,
          curveSize: sizeHeight * 0.15,
          style: TabStyle.react,
          height: sizeHeight * 0.065,
          items: const [
            TabItem(icon: Icons.home, title: 'Home'),
            TabItem(icon: Icons.event_note_outlined, title: 'Aktivitas'),
            TabItem(icon: Icons.person_rounded, title: 'Profil'),
          ],
          onTap: (int i) {
            setState(() {
              currentIndex = i;
            });
          },
        ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(sizeHeight * 0.12),
          child: appWidget[currentIndex],
        ),
        body: bodyWidget[currentIndex],
        floatingActionButton: currentIndex == 0
            ? Consumer<AuthProvider>(
                builder: (context, auth, child) {
                  final isMember = auth.userData?['isMember'] ?? false;
                  return isMember
                      ? const SizedBox.shrink()
                      : ButtonMembership(
                          backgroundColor: orangeColor,
                          textColor: royalBlue,
                          onPressed: () {
                            Navigator.pushNamed(context, '/membership');
                          },
                        );
                },
              )
            : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      );
    });
  }
}
