import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'reminders_page.dart';

const appGreen = Color(0xFF0da86c);

class FeaturesSection extends StatelessWidget {
  const FeaturesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Quick Services',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See all »',
                  style: GoogleFonts.poppins(color: appGreen, fontSize: 13),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            children: [

              Expanded(
                child: _FeatureCard(
                  icon: Icons.medical_services_rounded,
                  title: 'Emergency Help',
                  subtitle: 'Emergency Guide',
                  color: appGreen,
                  lightColor: const Color(0xFFe8f8f1),
                  onTap: () {},
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _FeatureCard(
                  icon: Icons.notifications_active_rounded,
                  title: 'Vaccine Reminder' ,
                  subtitle: 'Meds & Vaccines',
                  color: const Color(0xFF1E88E5),
                  lightColor: const Color(0xFFe8f0ff),
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RemindersPage())),
                ),
              ),

              const SizedBox(width: 10),

              Expanded(
                child: _FeatureCard(
                  icon: Icons.location_on_rounded,
                  title: 'Find Vet',
                  subtitle: 'Nearby Clinics',
                  color: const Color(0xFFFF7043),
                  lightColor: const Color(0xFFfff0ec),
                  onTap: () {},
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
  final Color color;
  final Color lightColor;
  final VoidCallback onTap;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.lightColor,
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
              color: color.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: lightColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 2),

            Text(
              subtitle,
              style: GoogleFonts.poppins(fontSize: 10, color: Colors.black38),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 10),

            Container(
              height: 3,
              width: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
            ),

          ],
        ),
      ),
    );
  }
}