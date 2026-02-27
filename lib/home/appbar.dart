import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const appGreen = Color(0xFF0da86c);

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: appGreen,
    elevation: 0,
    iconTheme: const IconThemeData(color: Colors.white),
    centerTitle: true,
    title: Text(
      'CarePaws',
      style: GoogleFonts.poppins(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.notifications_outlined, color: Colors.white),
        onPressed: () {},
      ),
    ],
  );
}
class CarePawsDrawer extends StatelessWidget {
  const CarePawsDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          _drawerHeader(),
          const SizedBox(height: 8),
          _drawerItem(Icons.person_outline, 'My Profile', () {}),
          _drawerItem(Icons.pets_outlined, 'My Pets', () {}),
          _drawerItem(Icons.settings_outlined, 'Settings', () {}),
          _drawerItem(Icons.info_outline, 'About CarePaws', () {}),
          const Divider(indent: 16, endIndent: 16),
          _drawerItem(Icons.logout, 'Logout', () {}, color: Colors.redAccent),
        ],
      ),
    );
  }

  Widget _drawerHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 24),
      color: appGreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 34,
            backgroundColor: Colors.white,
            child: Icon(Icons.person, size: 36, color: appGreen),
          ),
          const SizedBox(height: 12),
          Text(
            'Joey Tribbiani',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'joeysandwich@gmail.com',
            style: GoogleFonts.poppins(color: Colors.white70, fontSize: 13),
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String label, VoidCallback onTap,
      {Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
      horizontalTitleGap: 8,
      onTap: onTap,
    );
  }
}
class ExtendedPart extends StatelessWidget {
  const ExtendedPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 32),
      decoration: const BoxDecoration(
        color: appGreen,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, Joey 👋',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            'Smart Pet Care,\nAt Your Fingertips.',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),

          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.location_on_rounded, size: 18),
            label: Text(
              'Find a Vet',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: appGreen,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
          ),

        ],
      ),
    );
  }
}