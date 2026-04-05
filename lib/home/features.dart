import 'package:carepaws/emergencyhelp.dart';
import 'package:carepaws/findvetpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reminders_page.dart';

const appGreen = Color(0xFF0da86c);
const appLightGreen = Color(0xFFe8f8f1);

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Services',
            style: GoogleFonts.poppins(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),

          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: _FeatureCard(
                  icon: Icons.medical_services_rounded,
                  title: 'Emergency Help',
                  subtitle: 'Emergency Guide',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EmergencyHelpPage())),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _FeatureCard(
                  icon: Icons.notifications_active_rounded,
                  title: 'Vaccine Reminder',
                  subtitle: 'Meds & Vaccines',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersPage())),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _FeatureCard(
                  icon: Icons.location_on_rounded,
                  title: 'Nearby Vet Clinics',
                  subtitle: 'Nearby Clinics',
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const FindVetPage())),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: appGreen.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: appLightGreen,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: appGreen, size: 26),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.black38),
            ),

            const SizedBox(height: 10),

            Container(
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: appGreen,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ],
        ),
      ),
    );
  }
}